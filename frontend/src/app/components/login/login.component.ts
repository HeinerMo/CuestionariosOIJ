import { Component, OnInit } from '@angular/core';
import { FormControl, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { UserToLogin } from 'src/app/models/UserToLogin';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  userNameControl: FormControl = new FormControl("", [Validators.required]);
  userPasswordControl: FormControl = new FormControl("", [Validators.required]);
  isLoginIncorrect: boolean = false;
  messageToShow: string = "";

  constructor(private router: Router, private userService: UserService) { }

  ngOnInit(): void {
    if (this.userService.isLoggedIn() && this.router.url == "/login") {
      this.router.navigate(['/'])
    }
  }

  public isLoginValid(): boolean {
    return this.userNameControl.valid && this.userPasswordControl.valid;
  }

  onLogin(): void {
    if (this.isLoginValid()) {
      var userToLogin:UserToLogin = new UserToLogin({userName: this.userNameControl.value, password: this.userPasswordControl.value});
      this.userService.login(userToLogin).subscribe((responseDto) => {
        if (responseDto.id == 0) {
          this.isLoginIncorrect = true;
          this.messageToShow = responseDto.message!;
        } else {
          if (this.router.url == "/login") {
            this.userService.setLoggedIn(true);
            this.userService.setRole(responseDto.item?.role!);
            this.router.navigate(['/'])
          } else {
            var url: string = this.router.url;
            var startAt: number = "login/link/".length;
            var endAt: number = url.length;
            var questionnaireId: string = this.router.url.substring(startAt, endAt);
            this.router.navigate([`/questionnaire-view/${questionnaireId}`]);
          }
        }
      });
    }

    /*if (this.userService.isMultiOffice(this.userService.getToken())) {
      this.router.navigateByUrl("/office");
    } else {
      this.router.navigateByUrl("/");  
    }*/
    
  }

}
