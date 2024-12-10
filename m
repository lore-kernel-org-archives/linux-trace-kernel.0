Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA001B4221
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841844; cv=none; b=eyUooRqNorOeKL/KYM60mH7K1Ea0wKdme7ekSF7MU9wleMGxM3lq705dQ2VuDXkcKdSb99mDKlU5k+QYZ8cAvGvR6EgxIJAp5a2PnlFrfF9ggMwM80ZpsUPuFV9jBXWSRZqDGC1Tt7hq70/f1BrjSNC6K1e30Pwvpgvb8dgFiqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841844; c=relaxed/simple;
	bh=UJwFBO9vbEOarQQdzEAtnm6eWrTvYdifQjQmy9S6VNk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Sk+vA3WNoyr88lpzwfLIrA0Mu51gRgvKav1Ax/zx9KOm6Oxtse5mrI9TjqDCTJRTVxjU7Vib3cIJwiXTpvv/VNTYnqdRBWqN4/rur+Hvx1UMjOT+oXryCq9wgTBkT6Z1woEO9wA71txKLVQVB71SxgU/GYekOUyqB/xOZVkGbqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a81777ab57so33722935ab.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733841842; x=1734446642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wHRmglB/uTlqO78lWJ+GcsToPOMC3b4XV7WsgLDkrd8=;
        b=qi3ig92GrXqQs+8gvHiM2z8rGp69/b6vEXjxobw9wyWR6bnEzPv81KvBKpANs8HLV1
         a/87wZlVRcaYczAefmidXjw625P9SRcVI7jAZZn3HTKmkyqLSmeuuh+aJVjV2u7jy1ms
         W5W07IORlICF59um43gpS3zr9pC/LGzs27ouzQPofhfjXBsj/nNKpGMP0OMowO9Q1Wwx
         mB+zPlUN1hXmg94EsebZbadpstD2xOb4M9kKKIpYa0uA3MyW3/40h/z2LP+s9sbBadFx
         DfgT2ADq01roX4moXLG9kzZv74GhhoF9wkjT5MmLOIX+36RQ+APihpC3vL+Iz+gFQIuT
         RsKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNlZd5lH7bf6RcF96bdJhUoTmWc6GGgCMkdn0vpn74qSRZUtmohkeA2JpNwzzoCy53CaVFlqXEenAun3pz+ObrG6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzubX4AZbzc/B+0vXZkqiEFOtn3JLWEKnZP4d0eeUwXjtDVVth0
	HM7gjFIrJry4Ywcun4QoI0/yZvWDxwiikW6IsV+1ywunlfMVZbU3SjfSZiJixSzFjJjuS5k6WqY
	AyBTEm59qWDoTgbI7pPrO+zAFWm1BjoqLfXK5ySEMuPz5zoASaB6HAes=
X-Google-Smtp-Source: AGHT+IGGgYznzK9FyGa6Y3SQoRd69Sy14L/LftCeFxE3fEamhn1CYv6QsyjuW4JiisG7CRdwe3bBn4Sam8D0BTwyfYYIVTU8kMOm
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1786:b0:3a7:a69c:9692 with SMTP id
 e9e14a558f8ab-3a9dbb2b21amr44928275ab.21.1733841842547; Tue, 10 Dec 2024
 06:44:02 -0800 (PST)
Date: Tue, 10 Dec 2024 06:44:02 -0800
In-Reply-To: <6757fb68.050a0220.2477f.005f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675853b2.050a0220.2477f.0065.GAE@google.com>
Subject: Re: [syzbot] [net?] [afs?] WARNING in rxrpc_send_data
From: syzbot <syzbot+ff11be94dfcd7a5af8da@syzkaller.appspotmail.com>
To: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	marc.dionne@auristor.com, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit b341a0263b1b804d329f864c2dc24815364510ec
Author: David Howells <dhowells@redhat.com>
Date:   Wed Dec 4 07:46:46 2024 +0000

    rxrpc: Implement progressive transmission queue struct

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17bbeb30580000
start commit:   e58b4771af2b Merge branch 'vxlan-support-user-defined-rese..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=147beb30580000
console output: https://syzkaller.appspot.com/x/log.txt?x=107beb30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1362a5aee630ff34
dashboard link: https://syzkaller.appspot.com/bug?extid=ff11be94dfcd7a5af8da
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14cb93e8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a3d4df980000

Reported-by: syzbot+ff11be94dfcd7a5af8da@syzkaller.appspotmail.com
Fixes: b341a0263b1b ("rxrpc: Implement progressive transmission queue struct")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
