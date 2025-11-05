Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6149726F289
	for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Nov 2025 05:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762321686; cv=none; b=cZRl4IlavP29aYEs2ZDUaWMjW4vdWpSVIbkDl0GJQG1crKEqnofcJZ19w0QSITd2WApy5lIoLt4lG6J8LysyELsi/n9B3+syCMO4N4WgLR6tnBodQqK5lclSHua5/8FgRGhUoxbXMlcxJ9+PbgbhGydQoFFwWtQH9wLt7D6cLZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762321686; c=relaxed/simple;
	bh=GlQIhOpVt8G+BVYMy665LNIo97/TwQy9Ja+ALJ1AUDo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=W+yNlQlJBJEHCrZPbY14ZEHesQEzzKscR1QSqAZnVw6TmZa8Rj1PtFW2G44UQOxBjRg145GDpp1CxZhrN8Qtbx24D9CxksEjQncInGv19x0BJM23M7Zgvl0JqEB2gtv31lgK2T4LEZqUKWbduCqE35luYOd6cXB5H67oZ8eET20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-93e7b0584c9so534844639f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Nov 2025 21:48:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762321683; x=1762926483;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g4XDLXqrEs29g4qhc4+ZUYTByJ5LUyYE6CBWzXLnGEU=;
        b=X+EUr5tLawFdujaZjUUD+hXQR9qQ35xMCqziQQ1g7ToAlOoRABd/dzyLK6x2wBagNt
         MmbWFltUWmrWb0pL0enmbQPPi0RLV6rw7Ldi+VvPrUf2z/H4J/YBFbXKZ7SadXsjHZAh
         6FoiMZQ+dX6f7AtunGfXbMiN8fJmDU1YkWYVBZTdsuFDpbvBLlcRHZvkL6+rrF3mPHLv
         /sQLpcAYxEK8d0IqMfFad8rcrlb7nICLxkwDgM67rygHcsj/3WMPWW9NihCybAIZsXa7
         bmGudtHVzolURj9+1nmwPET/I8oNunRP9ddTi07iYuupNeNhQ0m0xJj0ZB3ESkbJy14E
         Ovqg==
X-Forwarded-Encrypted: i=1; AJvYcCWKpP9xmdLZKFVq3fXjCqRC+uOfFOyX0qJWRpaitNVb7RaeBq9cxsrMkuMuEkduw/VkpCC18fdhcu6LGGqoSrmRjrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8CyDchUjR+EArl9plbzzhiK3UgQE1TMfIrUaLq44Btp3vyR64
	MkizauZe1HA5kG05WaU1b7Ltr1XRxLSuDiEQTLx9EpCPjJsH5biByeLf7OHEOKW2SJf40YTLHnB
	2ekGCstB3W6kchk2A0CAegiDqHXMqDjnu0RmoeYDkGK7xKkTFGa7OT4FRso8=
X-Google-Smtp-Source: AGHT+IFp+75P9fzMNP6tFwZqfyhcKVqnVaql1CMi2hGDeHUR9fDxpaS8IRIyJ/54rHYeSSnjNRL0DzJ+OpUzQhVJDknW+FXvnEk4
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:29c9:b0:945:9f2d:592f with SMTP id
 ca18e2360f4ac-94869ebc957mr295259839f.17.1762321683439; Tue, 04 Nov 2025
 21:48:03 -0800 (PST)
Date: Tue, 04 Nov 2025 21:48:03 -0800
In-Reply-To: <68132c08.050a0220.14dd7d.0007.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690ae513.050a0220.baf87.0009.GAE@google.com>
Subject: Re: [syzbot] [nfs?] [netfs?] INFO: task hung in anon_pipe_write
From: syzbot <syzbot+ef2c1c404cbcbcc66453@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, brauner@kernel.org, ceph-devel@vger.kernel.org, 
	dhowells@redhat.com, ericvh@kernel.org, idryomov@gmail.com, jack@suse.cz, 
	jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	m@maowtm.org, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	netfs@lists.linux.dev, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev, viro@zeniv.linux.org.uk, xiubli@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 290434474c332a2ba9c8499fe699c7f2e1153280
Author: Tingmao Wang <m@maowtm.org>
Date:   Sun Apr 6 16:18:42 2025 +0000

    fs/9p: Refresh metadata in d_revalidate for uncached mode too

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10be532f980000
start commit:   5bc1018675ec Merge tag 'pci-v6.15-fixes-3' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f5bd2a76d9d0b4e
dashboard link: https://syzkaller.appspot.com/bug?extid=ef2c1c404cbcbcc66453
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15631270580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a0b0d4580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/9p: Refresh metadata in d_revalidate for uncached mode too

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
