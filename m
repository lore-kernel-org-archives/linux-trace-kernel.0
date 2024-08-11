Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15EE22EF0
	for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Aug 2024 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723382944; cv=none; b=OH8QBcRF5Njm3gO7HgUO87ARBVSbOJtiOgkVnHc01laTiBUEpW3ogfuFZrtZnkB96fAvHJWu1N5kh4Q8rz0M8Au88JwUbJQhqO1YOwnz0NugnGxwTlbc9eGG+F2181eb2gMZxGCAwfQQ57IhDgqEI87H3Y84jXe71VmjlgMSTRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723382944; c=relaxed/simple;
	bh=4VIJuiITEW7ewzHq3AA+up117C46Xna41EtTB6jRDpg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DEkIy9Z/VpRSnJOFCwhT6s2TowL467SuW5FNdnmq6M1QVJ3rfRA6Sk8daGJJz74he+tk8w2SFr62O5xxU/OmjzIIWrrGegteNW/knxvQaX5LXgkOPKG+89YrdfBzTJpiG9Rqimmb06ZryH7mZ1ww/CnbPytZQN+RaNh2CEeOGDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39aebcdfc3eso48668055ab.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Aug 2024 06:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723382942; x=1723987742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BnkKa50lZ8hs4Qk4BwOyGnKaIm3qqKKfma5Pq5XbRrs=;
        b=UF8wJg5bBnFgMP6cnKs/c5AUmrn7EoWk+PCNriuuUoqIFKiOKd/Cm/HJHTHyoML3ec
         3nuFDU0Faw1JDHp/9c9x0eXFbY1sTjpIl0tvoMLIXMAx8D3KpOvGzYclDeRZFd+3CQd3
         1FJNd0VlxIn0/8I37iXQ2+n7KrNSv4qc+3G/mmh8sPrdUSB5cDggZL9Di+ZLWrGSZWRt
         hFr5EQYa3GJm1sPlf1vBST9jScAF92tqpREbUbHIlSLTcv3tzTOyVWisOBVlDj6ej/kn
         mX/6l8zXcFaf8ufYxznWmcor9ddB1da21FCNNqMveV5LFQxemVV4K6lQkWr8cm8tWaBi
         5edw==
X-Forwarded-Encrypted: i=1; AJvYcCVFyKhg5gYfxYbhSyzlnlxlL3sC+XeuzfSolPYUIV0ACD8rb9V6zDmwUB6TKZ/XGnrIjGRAU9k+IUOfZpSEy8n0vwoFRsakevo7r/34TMIyHq0T
X-Gm-Message-State: AOJu0Yw1QDVcyPWsdptyEb3lHDAH5oxkv8T+icZJkLmXhCE1hoHDQ101
	Q/D8AOC2+He3KYdCUFfGSc+Aq/0Bu2ZzwEmgpaHbwVkS+Y2QxfDiimM+DzSNJx4eGiRCTxQLljr
	F9A5Z75BJF7JzG6Emp5jHNYwJMeBjQLqnyABPRRKMVzYOVPcXNQ/HFkI=
X-Google-Smtp-Source: AGHT+IF86Mz5uFG6noEffyBuynmhir8KuMZ4KINCzCYEAYQ+fD0uNmCOh4N+xL+7PJ1qedIPxl2odenKYUfLMEUCn/VWv3Q+BIPQ
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e8:b0:396:2d57:b1cb with SMTP id
 e9e14a558f8ab-39b748412dfmr4968815ab.0.1723382942031; Sun, 11 Aug 2024
 06:29:02 -0700 (PDT)
Date: Sun, 11 Aug 2024 06:29:02 -0700
In-Reply-To: <20240811125816.GC30068@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000127956061f685c79@google.com>
Subject: Re: [syzbot] [perf?] KASAN: slab-use-after-free Read in __uprobe_unregister
From: syzbot <syzbot+f7a1c2c2711e4a780f19@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, andrii@kernel.org, irogers@google.com, 
	jolsa@kernel.org, kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mark.rutland@arm.com, mhiramat@kernel.org, mingo@redhat.com, 
	namhyung@kernel.org, oleg@redhat.com, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f7a1c2c2711e4a780f19@syzkaller.appspotmail.com
Tested-by: syzbot+f7a1c2c2711e4a780f19@syzkaller.appspotmail.com

Tested on:

commit:         6a0e3826 Merge tag 'for-6.11-rc2-tag' of git://git.ker..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1430267d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=505ed4a1dd93463a
dashboard link: https://syzkaller.appspot.com/bug?extid=f7a1c2c2711e4a780f19
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1685014b980000

Note: testing is done by a robot and is best-effort only.
