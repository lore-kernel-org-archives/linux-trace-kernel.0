Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78A319E99A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732900507; cv=none; b=kHGSKlw4XPdWeXEITbVANOxw4UCEoHw7Kt4uv4l9UbZzdEofoNpE0t4Bb3U9TcSGRsc9xoEfIACtJ4KpcHlcimJ4XjjHAG2pVA1BFBE0f4yQRpZ+E2sfnuIxnPYCTj7tTI2iBZzAZJRYdIpYbLsy94MAx5jYV6on4uANmmMN72c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732900507; c=relaxed/simple;
	bh=GnhFjpEQk2QTU3xMRMxYSIU7Dc+xnhMFHvUYOX0FzPs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oKzUsqGZ+ynBSJJvEIeewL3nfqrnlJEgA6aatNwH23QMPTt5oNlfrqDBPbxHFedx2hxqlJlkOTBpj7/uzqlvg7h0ebTvv4OTy7fFefsuAM70fat4cE6cQJkcgruv6ugD/FSsdwA3urQNf1rmTmzYRHmgyMuTQimOzEaKyLhMPX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a794990ef3so25707795ab.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Nov 2024 09:15:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732900505; x=1733505305;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cabndGigWtS979m0rIc0e06+sfnwrdqk4oGx1hUPQVw=;
        b=emKZFPasn/HlixKFrD/5xEK89GWuJ4UWumbY3mZtUnN1LgShx840pu3kpJowpI5iAb
         ISwqSRMGU8wRawmvVfux/+QcAlal7ndPOMHqLguIUFsHH/VMArZoHw2eADjriZmX5XZd
         t42+sPlM1p0FBJWHUEtUHSXYLpkNCJdEldROpsSt10EOklrfKjNytyvuQ0/asJ+HY7F7
         +LZpelJ8qctmGfXmJZ6Gk1yos2l8z4R5VgCaYa6CoadVI2iGlfnr8DlBnyeVII0t41RM
         olLASu00lFAuSy5SUvSkgP9kr0gT8d4Jgh70O+K7TjK/Fr8+tg0RN46pryLiJUXA/980
         fjQw==
X-Forwarded-Encrypted: i=1; AJvYcCVhKxrRHmMVAoWfX+mzLAGHZ6wRVdJR6BCnEcnTLk1Hd6M6ogYi2NjQXDhdCDT1Rad8/EfuJQADv2vIS74lRII/80A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz05HmHbjsJBEfvv2q/7wOuT2yIC9nkMmid892rTQXbJmE2P4p/
	DNFcuKHl7apvuN/VLGR865E4p781K7Sfj/UEG17ghKScPBHJy8jFgWxdAtpXYmdP/rvrmsuXzFt
	Wm5vLyiwc+/hhHXLH3WyPWidbz+3G92HsknFtKCJCSYsX5q8UkWidyBk=
X-Google-Smtp-Source: AGHT+IHe8uD7Va/t9RghiydunC7nRHm/GXM4J1aMUOaYHKIypML+ORhOP4P4xsuLh0/azcIVXHk232/8no/NPRjgk/tTxHq54l6N
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a46:b0:3a7:c81e:825f with SMTP id
 e9e14a558f8ab-3a7cbd23d37mr83760205ab.9.1732900504111; Fri, 29 Nov 2024
 09:15:04 -0800 (PST)
Date: Fri, 29 Nov 2024 09:15:04 -0800
In-Reply-To: <4020304.1732897192@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6749f698.050a0220.253251.00bd.GAE@google.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_read_iter
From: syzbot <syzbot+8965fea6a159ab9aa32d@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, bharathsm@microsoft.com, brauner@kernel.org, 
	dhowells@redhat.com, ericvh@kernel.org, jlayton@kernel.org, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	marc.dionne@auristor.com, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	netfs@lists.linux.dev, pc@manguebit.com, ronniesahlberg@gmail.com, 
	rostedt@goodmis.org, samba-technical@lists.samba.org, sfrench@samba.org, 
	sprasad@microsoft.com, syzkaller-bugs@googlegroups.com, tom@talpey.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8965fea6a159ab9aa32d@syzkaller.appspotmail.com
Tested-by: syzbot+8965fea6a159ab9aa32d@syzkaller.appspotmail.com

Tested on:

commit:         2aece382 netfs: Report on NULL folioq in netfs_writeba..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git netfs-writeback
console output: https://syzkaller.appspot.com/x/log.txt?x=159cf3c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=225053d900535838
dashboard link: https://syzkaller.appspot.com/bug?extid=8965fea6a159ab9aa32d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1328f3c0580000

Note: testing is done by a robot and is best-effort only.
