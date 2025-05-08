Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DEC21D3D1
	for <linux-trace-kernel@vger.kernel.org>; Thu,  8 May 2025 07:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746688385; cv=none; b=HK5H48mD7T/otuR0s5rtJTvrm2I7uUjraWDR1rZUVJdq1UItSCI5suLPrq3n9Hh8iNOjSp+4Div8leDZ+egQG/UWdl57cfeL7KWNJnmG60AbUDVfbyXO9Dtm+AlpZuPCqt4FP/ZMRhP/2VCJrv5CzeSg55LNTT+X3rD/iDnMZQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746688385; c=relaxed/simple;
	bh=wzd2oN78a5f/c5RFfKUvSeNBcAm+s56MJoEcP0uJOJ8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qxuQpx5wwURqk3C8tX7ERahiltXxbztb5BphzOThZS7R16F95srw+uBNdu6Iro+J51qtl7YIPbt7US6K9WbUL4jxLP8/dvCUKMkD/eJ6cjGtEqNJJIThGf5P0xbQabN/h89sRx9NkAHtPnuu0Q8tlveIezudsN+tILYw9dA05ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85e7e0413c2so62306539f.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 08 May 2025 00:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746688383; x=1747293183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aG8nEEjrmEeVt+FMIpArijkqqoSXM+l5mTr89aXDaco=;
        b=cslaA1d1drqPQW/ZR6z0i/QxBpeHijRkr8ZzZxxaCHXAkxEY4NvaFCbxfdQC2mCc0g
         JBv9J14EaEZWjDgWsb9eCcHKeQKiEGmKYYuzmdT6/m8pNl6a71WcWMv0RruOMGquNvqz
         hzGhhM/xUfAq/mpwyI9mX6JjJ2V64hzGHe47XTgx5mJmaRjLn9Vgvvv3LtFnPdXtJnvg
         Y3+GIkp2rJeGsvxijiIxt0xtgM2f0xqyy6vEY453gJUmIrnep2I5Fr4LYaTB16s+YxME
         imlAfS84CGhbKkhvharNMKraugix35LDCf47D51H48vj9mDKoVlxzC9MZnkZA9ogqFNh
         7u/A==
X-Forwarded-Encrypted: i=1; AJvYcCUvXVCn9md9IKGVU+4n6QwBS5i303jROpV0qgN7CLaQ7GyI3JSt98JTrL7YBRTUl6vAC4TzVLbqZv7sJvc932tidSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YylvYhoKGyJaFF9vkybyG///3Yzg0G/igOFe+mTh/HHs1+501HI
	xdD+M/oJake2YH7DZAsprIHYWTwZtVWHJLFad5CKSJGu9rknpeQJ81F2Mz9qNmL2ZQe74czfKJ+
	PJYHtgAYsQh3842E/d/+DWoBwAdMzfDyqlIiDe8Ht0bIxj6dnRNqeJLg=
X-Google-Smtp-Source: AGHT+IGwtuBYqtqyXs7WRh4r9OmvUUEzOExCVcEqx0h1T1Y13Uv2G2YCBtq+f/KGXA4sXFhBQN7tN/Kda77poO16j+d/OJj+D8XX
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a67:b0:3d9:36a8:3da0 with SMTP id
 e9e14a558f8ab-3da7854d64emr31349925ab.2.1746688383016; Thu, 08 May 2025
 00:13:03 -0700 (PDT)
Date: Thu, 08 May 2025 00:13:03 -0700
In-Reply-To: <000000000000adb08b061413919e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <681c597f.050a0220.a19a9.00bd.GAE@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in trie_delete_elem
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, elic@nvidia.com, haoluo@google.com, 
	hdanton@sina.com, jasowang@redhat.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kafai@fb.com, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	lkp@intel.com, llvm@lists.linux.dev, martin.lau@linux.dev, 
	mathieu.desnoyers@efficios.com, memxor@gmail.com, mhiramat@kernel.org, 
	michal.kukowski@infogain.com, michal.switala@infogain.com, mst@redhat.com, 
	netdev@vger.kernel.org, norbert.kaminski@igglobal.com, 
	norbert.kaminski@infogain.com, norkam41@gmail.com, 
	oe-kbuild-all@lists.linux.dev, parav@nvidia.com, rostedt@goodmis.org, 
	sdf@fomichev.me, sdf@google.com, song@kernel.org, songliubraving@fb.com, 
	syzkaller-bugs@googlegroups.com, wojciech.gladysz@infogain.com, yhs@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 47979314c0fe245ed54306e2f91b3f819c7c0f9f
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Sun Mar 16 04:05:37 2025 +0000

    bpf: Convert lpm_trie.c to rqspinlock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=140598f4580000
start commit:   c2933b2befe2 Merge tag 'net-6.14-rc1' of git://git.kernel...
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=d033b14aeef39158
dashboard link: https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108e1724580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177035f8580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bpf: Convert lpm_trie.c to rqspinlock

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
