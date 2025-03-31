Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A181421ADC5
	for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Mar 2025 22:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743460145; cv=none; b=FHRzw0jyeahz6r9B6q5+6/koRHDO56avVwb0xylfINUr3LDBuHLHTtEKxVEe3Yj/CorG/yFv/BRdQnxIdrUzMr5IFSg7jSaPptVKwL1clqWz1S6CpEJC7hGw5fLWwkg6WH5EakKcdebAVqTaj8P9FdC38KgHBUfENBAfk4xMab4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743460145; c=relaxed/simple;
	bh=UuuVTsYm2Zxjnrhbd/qR4M1gwPPLDDfTdGoa8/t6U4s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LwUilwMLs7pQQQcSROJMm/KuR4JdX5JC86Xx4mu+Om01JbpWAXzyH9N0uDqDb/43wT1We8uYyKMKwO+6TPJwgx3C2xxFcU4kwsQ9tialdbODSyQawu7U8drpRcGTDZEhYLl8Uv+Pha9gGtWj0daTAh3ZQIdmQwLEcpQXh1lVd+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-85e7e0413c2so414331839f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Mar 2025 15:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743460143; x=1744064943;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nSVL4Kp9k+wGSObtKqzEFngCrAg4gDkTKkxR0g4Fz+o=;
        b=JW6CwRa9Zhps4BOfLPJGIkLMci0kF80QkjAhnddy1FOuQXdNDRcf70LDWrfWxTf8HK
         Lcg4pxkxLvT0KGUBtqNmGoAwvepRSGMjQn/XBLD9qbdDM8G/raKov1iKa/+Ldy6BRvwj
         io5LjrmEUoqLCEe4msDH2a5XkM+urj3xlI0Oq3Im+MuamT0kHp7+GDBSswuHmGFR/+ad
         jVDBGeRqcZNy0uEVs4kcviZiflX8bSUqJoruvuD3SC52jekI8C+A5UQRJ1yh1tDeTlM6
         g9kt8/l32FtRXTZPtH59sH6QplCvQG2ycYm+S1VIZusriKgdUXiT/a6T4Htbf8o6YuOM
         0+dA==
X-Forwarded-Encrypted: i=1; AJvYcCVQOzHJPPIBHJ5zBjQvCQaUvWhUg+uGLaf59iuTPRZNzrkoWX5AyLWnTOJ4iSKE/ovthT+j8IJ7qlh6b+as414KKxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrIlXgdVwSblGI2smozg7X9MdxPSD0YnXJl28EPk6khykcQoNo
	cDSaOe/pOj8TVQeEfEhrpPogKiwslsYaHDoyesrsgHjpbuINVNL9y2JeUGhWY3RyurbdJj5B6MV
	//lA78Oajq3xfqiG8/0ELov6pBGl+/3DV17vp9B1X659yMXPQ0CfSVRQ=
X-Google-Smtp-Source: AGHT+IGhulxDGj30rHN5fxtAq/fPZbdSpnFuBtPejDjr0uCyV7Dtnz334K3BEYh3LNHWAESQIEL8d4zK76dJIn4o/WrkIUBbrg1G
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f0c:b0:3d3:f520:b7e0 with SMTP id
 e9e14a558f8ab-3d5e09094f8mr100657485ab.6.1743460142793; Mon, 31 Mar 2025
 15:29:02 -0700 (PDT)
Date: Mon, 31 Mar 2025 15:29:02 -0700
In-Reply-To: <531210.1743454065@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67eb172e.050a0220.1547ec.0179.GAE@google.com>
Subject: Re: [syzbot] [afs?] WARNING: ODEBUG bug in delete_node (3)
From: syzbot <syzbot+ab13429207fe1c8c92e8@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	marc.dionne@auristor.com, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
unregister_netdevice: waiting for DEV to become free

unregister_netdevice: waiting for batadv0 to become free. Usage count = 3


Tested on:

commit:         1e7857b2 x86: don't re-generate cpufeaturemasks.h so e..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12692404580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=56c806e1bbb36dee
dashboard link: https://syzkaller.appspot.com/bug?extid=ab13429207fe1c8c92e8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=178cce4c580000

