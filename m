Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1B013049E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 13 Nov 2024 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731518526; cv=none; b=J1+zkT1gYFV+cBdzbmFVD/8IAbhbyFevKzshdAvVvz/TWNFKujud3aWS2hdi7QKBeka+qTXo9FpCYDyLwGNA/nq32+urwY10S89Z8tM2qPf6ueHM6fqj69lRmMru7f7qTd+EYc5Wj3oAXXcQ0eMBPc8vr5N+tP+89MRME1bjDMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731518526; c=relaxed/simple;
	bh=Z2yvubv1C3jHp6QXvOC/+j9/4t0h3OAD2jGZoHdUtJo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lVJhBQdk/oA1FP0sOZig/7oPoV85sgkUCwKyT2+ugvZdhXu0+4k5CDAi3UdIvHmrURKwb6/lxzZfygwZ2gmo+73/rXhR0XTPEfXgjl1Np6OPF938WjVCXu7A7TqEYxIJV9wJ2IQJW78blSW4pfVJMi2jeYzwyN+QoWGjsBXkIVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83ab4cadf05so795597739f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:22:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731518524; x=1732123324;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JnOf36aP94RKBx0LKLDwa8vZa06z4Rk+yvwFlv0FEFc=;
        b=LXIfRZIGtDnte9m9yfUdXrxaptiDfZTdRrhSv0XkL66ssMXohHUpikAXZhDESvLyzN
         FZXHT7iEKlabp1N707sdMYC+uQYZuKULfU5c/CYL75Ncj6D1BZRFLyankG9wWX5q42Nx
         jzxnhx6yom9UPWiSfKZ4275UIbEfmnZLxYnbzx6eCdk96qQiB0Z/Oqcxj+d+30x4E9TM
         mSf1NLoY/BbffMMthKHO65oh07ykai5UnerzLvyZlnmGfQgQ2ctnbFJ5olW4r5kA23/l
         /ENkq5FnrRQ/afXv61jYlN5BVmSz7HMAsCt9m2okDL+ZYo466l0iAdlnEdlo7lcVUR7U
         tt9g==
X-Forwarded-Encrypted: i=1; AJvYcCWckAdOF+2/vHORURTJBiKBQmb66QnDn60w34++qG4QveCjbusQx6FFauTsbizFAbp9tktdDQgA9+sl6um56VXOx1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHMVVenpKa+wpSCssY2/RS0HRU8FKkvrthuqWWxipnnD2wJhAJ
	HrVl2BDfcFbxF7MTsJ+dtVBdizbeugIgGE2Mwf6mhhOeuYuOtzW4VKlC+zC9Apa+UTGMcTGII4a
	2n7IK7zS/98bAWekU3qn5+8uDTRc7AvUErvT6Wc8QL6Bw2tTPmgR4JFI=
X-Google-Smtp-Source: AGHT+IEgQtmLGOHg1sQ01VClhxTRs9K7Qj21K5aCs/Tm8TEIqRm/Hmmz09IzpN/8iP4SWCVdpKm4EOH9JWYpabOweVUk1mKlM+KS
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3082:b0:3a7:1de2:1d9f with SMTP id
 e9e14a558f8ab-3a71de21df7mr2684235ab.13.1731518524539; Wed, 13 Nov 2024
 09:22:04 -0800 (PST)
Date: Wed, 13 Nov 2024 09:22:04 -0800
In-Reply-To: <0000000000002b1fc7060fca3adf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6734e03c.050a0220.2a2fcc.0045.GAE@google.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
From: syzbot <syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, andreyknvl@gmail.com, axboe@kernel.dk, 
	dvyukov@google.com, eadavis@qq.com, elver@google.com, glider@google.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, pengfei.xu@intel.com, peterz@infradead.org, 
	rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit ae94b263f5f69c180347e795fbefa051b65aacc3
Author: Dmitry Vyukov <dvyukov@google.com>
Date:   Tue Jun 11 07:50:33 2024 +0000

    x86: Ignore stack unwinding in KCOV

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=174bc1a7980000
start commit:   7a396820222d Merge tag 'v6.8-rc-part2-smb-client' of git:/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4059ab9bf06b6ceb
dashboard link: https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14669c6fe80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d23ae3e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: x86: Ignore stack unwinding in KCOV

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
