Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0715C3D984
	for <linux-trace-kernel@vger.kernel.org>; Tue,  5 Nov 2024 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730790908; cv=none; b=P93oMwKRPsJh3CptqymAS29cf3Ixe2M2oOMcbs1p3QciIy740PIMc7OrraG1uINo5kHLyfjg0ejxXfvTiByoLWgM8dzOn14b8afU0RzAKZgFPt+xe54bBvjdUe1+P8lxXNQDq+BC8/ZNPyo2xFb0r/InV2+B3TgClnOJSJs/JZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730790908; c=relaxed/simple;
	bh=AX0wnbzOVWBFJ0z+wYiz1cnR1V/qBBfEQHs42pi4lsI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RyR3C0qnZOq+yK4ujrIKFwFu0qY/O9T5IO5s2kDsKr4Rsv27zaYCpmOxl7kWYJRwBLH+ThJVYZMd0ETWkxg3p0+KEiRvP66pKbYV9W8xMBHXLjt7wrPH9UJmkKkCDnm3vB04SpX74R3YO2Z4sqryg6u8BXYkBUetpx9wJ80VGs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6add3a52eso35278685ab.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 04 Nov 2024 23:15:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730790904; x=1731395704;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=udJxfntUylZegD12LXtHmkhlsFp21Pyjgi/GZHXO0Q0=;
        b=bxQUHGMg7Lur+DUaiRfcxAx5cM2TMTej6ZtwCEr6sjASjA7MxLqTX/b4Yb2Z43Rb+P
         fkY/X7gh3dzLi5o/+kalquQVzDSg6j3im2BWPBVMfvhMFcKq/PPQ7jS7HHgIKqhn6G90
         I/NmsXpFvM3I7AXoJo30dxoChBTSfhC8jPq4fIXFuDmk83FHkTdnkaWeqlP6WqEbAIYI
         8WzEQ/GqgDJBswx4jozTTY/G4EkYdKBy97CBmfylCD7bSFrgDECz9FkNQNkhU5bBsyMS
         Su1NajU1cGEX76NbiM8PHbPgKJZKnZTQFwCdmboA50xowRlWMhq2vC5ZcsRE5Xsj/eTE
         ugrA==
X-Forwarded-Encrypted: i=1; AJvYcCX0zYRAgn40YmxOvZwJpcWQu7zrvS7AfmR5O38Cy4pMIEMV7JTSUwTx/0eN7mjM8/UYPIuHcoDGoyaa9x9clJqwCoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMPkKc3eGUS8aHk7dyiLKzJDcl0Gve3Y7wnqjvw8vZCStKuGG9
	jlM+Gt/hCMDuqPWNtp1GJPHMTIGfHOz9Dp7Bpca4HLcPNtfP6P5H7kwW0SWGvJcRuSn7K+2NRv9
	luTG1IcwxYw/XKCPKLIMDRoC+3FZ2DkIZkQOALxE0ts9j948rMt42QBM=
X-Google-Smtp-Source: AGHT+IFENoTKKV4sJFxJHInjEOnTWgVx2bbjvJL+998wFc4aiBPfOT49lkWevLcZGh8gALCc97t8JyVFflWcXBzoaOwhSWirGlcN
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1387:b0:3a0:c8b8:1b0f with SMTP id
 e9e14a558f8ab-3a6afeb07f8mr149769545ab.2.1730790904212; Mon, 04 Nov 2024
 23:15:04 -0800 (PST)
Date: Mon, 04 Nov 2024 23:15:04 -0800
In-Reply-To: <Zym_h_EYRVX18dSw@fedora>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6729c5f8.050a0220.2edce.1503.GAE@google.com>
Subject: Re: [syzbot] [block?] [trace?] possible deadlock in blk_trace_ioctl
From: syzbot <syzbot+a3c16289c8c99b02cac1@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, ming.lei@redhat.com, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a3c16289c8c99b02cac1@syzkaller.appspotmail.com
Tested-by: syzbot+a3c16289c8c99b02cac1@syzkaller.appspotmail.com

Tested on:

commit:         72697401 block: don't verify IO lock for freeze/unfree..
git tree:       https://github.com/ming1/linux.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14e8ed5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dfea72efa3e2aef2
dashboard link: https://syzkaller.appspot.com/bug?extid=a3c16289c8c99b02cac1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
