Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF062CAB
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Dec 2024 01:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733533264; cv=none; b=AO6i7LBT8lxOdEgtkzE2/cfIH81m++EhZdHuuZy4FkAnCKZf5YsM98iyoLMlIepEulRd02GOxNYxzKUTCQrN5wwhryrtWw+fD83jLH4lRAGUnpSzKIFvKHvdcG0WrXAlp33PLXi6jNKTz98Y97NkJB2xx+WEk4tu9ixz18/sKcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733533264; c=relaxed/simple;
	bh=u5nYSuuVesD6h7IbFSGckAHDRhurDNBarUCwXsucC0s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gpdqwTK5mpC4fkhpi+Wt9OFtcsoCizbA4mqIIfE3W46kmfXhzHPAz1oWpq7FySLfEzMEcBGR0Wx83PzA5zp7xZKxXUpIU+Eeiz7LH3Bnx6ORw/qr1SiYHE5AmXGEgVFrqJylKaXdKqySYgh3bfJyChMqc9r8t1dQ/tV2N3BM88A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-841a54a6603so461539239f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Dec 2024 17:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733533262; x=1734138062;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JvbLDdytkVXjmJCFEeXCmgooAVyAASqwNDMq6NqMYEQ=;
        b=MZUs+/xkC7zPfyqK7BTHXpjhgYmpHMKC4DqMjSrx5uSeSn8eJKteIKzB1vovwojooc
         06gJZsHt83TxGeO+bsaGI2G6AzNIwOJWBproj2f43onLMrVHAYbl4VlnabImXD8Cwcjj
         x1p6UCCnsgws767fKAy4PSj9Bxkbyy7Q5h8MWIzZiIcmbxfA94HDSbpG1J/EwYJjTQcY
         p/H66bHFv9hccLedVUvLpd369Fjl3FQsPPWKjfaYKIF4lT5KL+g2dt/J6uQWhlDJZi1N
         onEpG3orlYWr+7XTjU1momK48LwalEW6HBbxM1VDEdG/hLA79HFSyUhyIRZw1rG79hNP
         zr/g==
X-Forwarded-Encrypted: i=1; AJvYcCWvQYa2n+pOBAdIxOxz4byUv5utNR11nXpH/Lct5RSy1TlftFGD6oU1ceIu927SbOjtLcfDuCPh5/2GcEFav8/fHrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YznZqjw/a/SO8Qgjd7T+6JlDEKFwcJ86b0NvMnBI3jZu5vp8Atm
	sTzXu04ScvSxl8KvEFMfFhX2vwBMo8FGUndfxSRpmT2jn6GoAWuo7G94XIwP3beEqoNYN32eZrg
	7x22PurYIEgsiMtetNHw3AP20kRSKtTt1KG+rKXXOMU0ipRMCx1F6RCo=
X-Google-Smtp-Source: AGHT+IGWwrqQngiWMnwECL++Pbfxx6p8Bbp69VM3OYAspBdp6DqhMaIJQSDxdHce6v0Fp9jvolV/mRx9u6SQnKRscTy5tRUzIiys
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a7:b0:3a7:8720:9ea4 with SMTP id
 e9e14a558f8ab-3a811d77228mr65586115ab.5.1733533262498; Fri, 06 Dec 2024
 17:01:02 -0800 (PST)
Date: Fri, 06 Dec 2024 17:01:02 -0800
In-Reply-To: <67530069.050a0220.2477f.0003.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67539e4e.050a0220.2477f.000c.GAE@google.com>
Subject: Re: [syzbot] [bpf?] general protection fault in bpf_prog_array_delete_safe
From: syzbot <syzbot+2e0d2840414ce817aaac@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, 
	mattbobrowski@google.com, mhiramat@kernel.org, netdev@vger.kernel.org, 
	olsajiri@gmail.com, rostedt@goodmis.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 0ee288e69d033850bc87abe0f9cc3ada24763d7f
Author: Jiri Olsa <jolsa@kernel.org>
Date:   Wed Oct 23 20:03:52 2024 +0000

    bpf,perf: Fix perf_event_detach_bpf_prog error handling

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=103530f8580000
start commit:   e2cf913314b9 Merge branch 'fixes-for-stack-with-allow_ptr_..
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=123530f8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=143530f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fb680913ee293bcc
dashboard link: https://syzkaller.appspot.com/bug?extid=2e0d2840414ce817aaac
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132a2020580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1291d0f8580000

Reported-by: syzbot+2e0d2840414ce817aaac@syzkaller.appspotmail.com
Fixes: 0ee288e69d03 ("bpf,perf: Fix perf_event_detach_bpf_prog error handling")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
