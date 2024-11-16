Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7751885BF
	for <linux-trace-kernel@vger.kernel.org>; Sat, 16 Nov 2024 23:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731799984; cv=none; b=fJ4tEZxv0fIX3+poeCthdsRFWwfbC96PztxSXwsd2xYHvVUIa2aoh1CFDeKKt/R4qrNOmH31/a7XpbBMSp3bJuzd+Gv3R/eMfZMh5qIYq4VPe3tJ11LD5AzlU5cTvc+7L63VQZ8tUNuHfxM1JQrfgJhDS3NwurjCNtKVkna5I24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731799984; c=relaxed/simple;
	bh=ozfUCCvHD7H7cQd7d43iIoXCIgVvNpJ7H82PLjvW++Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iK+ldoP+mBl/HFe56PUZXTwLRkppLZ2EMkZ+LyyjZCyHtFrmstxCbOPOhaZQVxVhQN+5LsfstMVnx521vCTDDBryQQwruYSPolo+IzInb5UoHhcnu7L06YVRWJ2GdqleQ7iZcaQhUWdkEqc3kVhEv9jVtIWFBw49dG2kjxwIHHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3c5a6c5e1so36662075ab.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 16 Nov 2024 15:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731799982; x=1732404782;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6pPDlMybPfT5VSrJgcwp4WOC86rQWqblOSy8gJogtjg=;
        b=bRRpvbcf75J8/9c2xibCevD88R0KIli+KN87H3B6aBny26a3C0aIC4bOovhArBY9Hu
         8KDcwnSaVMIK+f/etu5QnnG4iYBkgWNzVTWibEQSc7+h7owHDhG8v4Jgtk2by2gQV2Sa
         WqIF0bU6R0Ru+RxMZ9GLTRwVKoab2pqdnznBGKUQuT0rHEcjbxDMUGFl0ReiVNpkjAxc
         9x37nFhpQ7gjTe6JIByjJSauo47jU0Z632yF8FY9QLeBm1gQV5eSlaQA16OYsFbB9nnD
         N1pnzX99FCCz6wDBvwOl0/78LScGBTZS7oD//Nc9JZzc9QvLgJTH2A0kjMmm0y8DeHDn
         Qi8w==
X-Forwarded-Encrypted: i=1; AJvYcCVCiUD07ZbX3bvjMxOiWdltprmWGcyB3VR2Xz9F/gJQv0eAl4PJdy8UhCpjQQQ5Vkv0IkscxoPN8t2HRJYeRw9nubE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySg0lCEvAGeb4RJ3DVnRJMomfPd5fEL3KH3/rGLMaAzG08Rk72
	TNvLMsrAbCCLMEl1Cq/G7gn9xxpreBkG//vHs/hWBKBfkDfwtwD9J37P9T/GCUoE0RtMJQdsinr
	PwPnb5ZeGgJfXkj9Vf8DDeFVvWtNz65q1ZSNrEwrHClXkyBmbW4YO2WI=
X-Google-Smtp-Source: AGHT+IHxQ9I2yZYOzjRu/LCFRev0gwqeF6CbR7jTx9glbHmeTnAWQobIRQzimgpPUOzK4oLe2zqzYITldOsYwITjPA3qJEI3bt+k
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b43:b0:3a7:158d:6510 with SMTP id
 e9e14a558f8ab-3a74800e163mr69240285ab.5.1731799981891; Sat, 16 Nov 2024
 15:33:01 -0800 (PST)
Date: Sat, 16 Nov 2024 15:33:01 -0800
In-Reply-To: <67336557.050a0220.a0661.041e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67392bad.050a0220.e1c64.0009.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in loop_reconfigure_limits
From: syzbot <syzbot+867b0179d31db9955876@syzkaller.appspotmail.com>
To: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, ming.lei@redhat.com, 
	rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f1be1788a32e8fa63416ad4518bbd1a85a825c9d
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Oct 25 00:37:20 2024 +0000

    block: model freeze & enter queue as lock for supporting lockdep

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=129b52c0580000
start commit:   929beafbe7ac Add linux-next specific files for 20241108
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=119b52c0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=169b52c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=75175323f2078363
dashboard link: https://syzkaller.appspot.com/bug?extid=867b0179d31db9955876
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b520c0580000

Reported-by: syzbot+867b0179d31db9955876@syzkaller.appspotmail.com
Fixes: f1be1788a32e ("block: model freeze & enter queue as lock for supporting lockdep")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
