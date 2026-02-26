Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4052374196
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772098985; cv=none; b=sgYaO1/IUcJMHt9D1RbhRZD+E0Ge6fk4ng46rjrE7Ye8ntfvn6XzRfESl/YYckh7SKS9DPMB8Y1wLbs4LdBGEoibqVqOlKwf7tVq3zbHCa4JMkqJ/WI0RA4WVZut/Zbxw4O0njLhLVH8kctwtFRcc95m0jxe+8zRuw9nzVfcVS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772098985; c=relaxed/simple;
	bh=nVBqfEfITP7Jo2Id0Sz+9G7g6m9CUACzlwphwKBqXUo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IN5w8LXleHs+5YOZPUjzEzbWJmFDi5PDTJeU1IbJZu4iCv0HMgKL3MCUs+hJSVGc55vaWGdkTJOFu9sDZ66T65BhnN/ik582BJzb+8rdCSRjG+yQAuObKo1FXsSkgU+YhTeWOW3MPr+A/Vpd7IlKiF1GIf12GmkCIoGZjMcNQZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7d4d4db1523so2654511a34.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 01:43:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772098983; x=1772703783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zu82HyZbDIaK5vvEFpd6bOoJvJZQkdOffCE+TjQ7Qs8=;
        b=lRlXZIOl6eWJII0Trz2HAxYkv9aG6Ah9sBULpPD83IiyA6kNO3sNwWfi2+AAPsWuVG
         5yF+Q2xatG+OG7e/0eYeZEIYG2+vQlj+cB2mxVJqojoF5C4UVYtKgwFElZjmTfnHFO1I
         iFCAxWBWuLtcKwzAPRqnrXg3uEwG1uzV1K/KO/GLmMDvnXezP6QvD+7YFE0jdrpYVt8o
         e4H7fVbvCnsEDpBT/FOEgSp8uV6uVl7CIb1R5SpZDmkMoD8m4GgOSKhUBrVyCU7jrax9
         D7mRrZ1eErp3MSPuImh6DsgHgrWxDkv6hrxaTmlOeRIa3mCRTVXA26ScUwarumZR7t7T
         wWxw==
X-Forwarded-Encrypted: i=1; AJvYcCU4L87KzrIEjU65XwyH+Wt9bSVcwdcnrJYgjFz3I2RuDe37v2zUtG4flf0W8l5u7Odvf+8FnPFobFEGhXegZYCNtcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDj+eybhzbCWpIai4GxydqJSxniLP1QMRFbRZmFNqQnfbX2zw/
	OYXZCELFYSJUjn7AR7Q89Cvna/H3OAjf7/qWeEcZ6j1Q31KzyoNh2mdAQX0fUPZqzGmH6KcEfur
	q8Ie8XPJUMHb551Wbln2K5WumX6x7QIITn81WuJgQacSRlfP69UmfX7z0Oug=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2229:b0:662:c8be:573 with SMTP id
 006d021491bc7-679ef9a0c39mr1478925eaf.61.1772098983042; Thu, 26 Feb 2026
 01:43:03 -0800 (PST)
Date: Thu, 26 Feb 2026 01:43:03 -0800
In-Reply-To: <20260226091657.895403-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a015a7.a00a0220.21906d.00c3.GAE@google.com>
Subject: Re: [syzbot] [trace?] WARNING in tracing_buffers_mmap_close (3)
From: syzbot <syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com, wangqing7171@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com
Tested-by: syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com

Tested on:

commit:         f4d0ec0a Merge tag 'erofs-for-7.0-rc2-fixes' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1222bde6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af6ed0125ed44356
dashboard link: https://syzkaller.appspot.com/bug?extid=3b5dd2030fe08afdf65d
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=145d4d5a580000

Note: testing is done by a robot and is best-effort only.
