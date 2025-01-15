Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F301F9A81
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 11:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736941624; cv=none; b=Yo+3BtRyiLVNpcvNtK9tof4JQTZofBKGF8YeDJZXx4zxkoaiHmxqtukxLq0uwQ6u/IMQDu8dEWZxP4d6b1OanPt/T2MQBAM5b3qz+N0DaOe/1H7e+gGtW8sqBeM/MdA6eq/30SmP9vKZDUUHarJCG+xrKCaDydxG1OLVstljcgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736941624; c=relaxed/simple;
	bh=/1uFD+772lAt1hJfYVdZ7oeg/thMmcYi5G7yE5q11iU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mivCPZ+Y6TUXgueMI6wP7VBIKGNG4ViQ4lplnDe/7RzlbH/Y084QC7PDP57JDafD9dlEr/bmzHFa++8FUt/fUXGFw1R12UyJvZgq05vrCQhb+ueO+ffwES3oIw7z/jLLKDOgLACG++bFcujVmYAwdSkZJjF2KQGqWKS59eYhrvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ce7c75cae9so6650795ab.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 03:47:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736941622; x=1737546422;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7CD8/bky+uBTitY/VMmrxb7nNioNYcVEol6ONXDjRus=;
        b=bNq+vVVaLpWNx6JVFhb4aGAvUqUgxpA7jZSAEdf39tNwm66E0YxhwJzSPlBRZAsDHs
         UCLSWgyWt1VCVtGRF4jb85Ckywrb7kcbuNfuaUBnTK4zSpcYFlqqflFtannPSS3IOHIW
         AAaJTNLO4P8E6crWjTR0baKcJ2jsMM0ntYptZqYUWaBHU73BaqfODspo3MLSyJ4uA7C2
         d650tsNJSk13QplG10HXdedQjrsqZ5zQBZAsYaidum6KpefzhGGlqtNwMQKMzTOt2hLF
         vZfD9ERGtGKwamRNDkWPuqaYbgTDsFHWt4HVa8Q19FsZF1fIvoqCsvOrWbiVqpwZaYfh
         C6QA==
X-Forwarded-Encrypted: i=1; AJvYcCXnryzqCdN32ZRjh+mKF5CB6Uss5zQld+xNM/LYUoz/B7S+r37vqSgOTjqEcU/mteyNJiT3aULdWfC2ob1L2ou7YBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu6kXWqPJyY3S3BF5CTOap2x10kS8wRO2xdw0+SI72/fCOsta4
	GM7b5KsJqSFsTpjCHy9hPVprmJdgNK8fIDa/bcrb+xuM8/yYeljW7K8j8Ps/FvraGjf5jdWR4RO
	jNcQMelKKi4cK/4Zms5puSPzREZW0zReAb7Lc7KXKRyPrw1x+kV+lUfs=
X-Google-Smtp-Source: AGHT+IESRd48rHGhudr/W5hTp4VTLrRNTk1+2Ra6errEaQt8aLT30h/PAr+bUUEcI7mPJrigCPSOnyk0dxCyxgomNR6tKHtcwEEf
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e3:b0:3ce:7cc9:9f46 with SMTP id
 e9e14a558f8ab-3ce84a25bf6mr18998895ab.9.1736941622558; Wed, 15 Jan 2025
 03:47:02 -0800 (PST)
Date: Wed, 15 Jan 2025 03:47:02 -0800
In-Reply-To: <mb61p5xmgicov.fsf@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6787a036.050a0220.20d369.0012.GAE@google.com>
Subject: Re: [syzbot] [bpf?] [trace?] WARNING: locking bug in __lock_task_sighand
From: syzbot <syzbot+97da3d7e0112d59971de@syzkaller.appspotmail.com>
To: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, martin.lau@linux.dev, 
	mathieu.desnoyers@efficios.com, mattbobrowski@google.com, mhiramat@kernel.org, 
	puranjay@kernel.org, rostedt@goodmis.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
lost connection to test machine



Tested on:

commit:         c547a7b6 bpf: trace: send signals asynchronously if !p..
git tree:       https://github.com/puranjaymohan/bpf.git bpf_preemt_fix
console output: https://syzkaller.appspot.com/x/log.txt?x=178257c4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aadf89e2f6db86cc
dashboard link: https://syzkaller.appspot.com/bug?extid=97da3d7e0112d59971de
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
