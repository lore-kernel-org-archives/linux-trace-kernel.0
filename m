Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6900B13E88B
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Jun 2024 23:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717543566; cv=none; b=BZZNGqeCVXZPPBUSU2sr12ZmzxTk69vgWak7VcLrajVluugQUfKUYeQzDF0rYWUkbLuCiTE10cOnEvn+IJSOoWtm9UcWhHFbS78u08ytBg+DptHltv14shGhIMGh7eNMWC+eSPP2hYz/B37eroSbxspVZOVpCJHSOp8Z4gm+1gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717543566; c=relaxed/simple;
	bh=uOxO572PIMYk4UD1AMdP6QiZNSv5xA+cPBiAG1f4D1I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZYrwhAGEMRNsVQlRAJ3GfCsCDX5tm7KvovZk03wG2aIklZVm9UhAycpNrkUMcDR+2RrB4d4weH/mStF/of2evEioMTkgKqlatl0ppiSzgp0mWhySAK8yWcsogxyLHbp8mqa8I2zFFAx1dCbn4qCMBIwe38n5wpH5e2RVJ/wL1j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3745fb76682so62128745ab.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Jun 2024 16:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717543564; x=1718148364;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i6eAuVeWTDMsF1yEe0WIVH8Cs9Fqf92OWhWU5p1no/4=;
        b=ApJZtFXjyq+VI6QZYiiwQrY8DCWv59o2NST3Hyy3mr/SRDeEpduO1TL/9i1a+e9IBF
         fkaSEARpI3FFtwY2VhkMrE5MvECm4i8IbZiSKFnklAsGgnUaLcL1ieI7eCNk1U6yKkwe
         tyLZo54nKtckzRse+WHC6oWTy8yOLawm6EWfQ3eKDJkp3aFkNHigLU0ZbgBlnb1XL6mD
         JfFOCOPBappEEnVkBqt2yAGQILzZQHjI0+Io7wl8jqkuQdkoOauJKNMLn5G5F8GnUGC4
         jLQPvXpNy+qRTSj7UrmulwMzmWZuy3s5pLC3/GsXJsU9xo2bzcYD0xwVXsTWFr5MBkmO
         akfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYelTJPJ/Y3VXMqQswfPbxVKCDfLMromAm8zvitSODDVAxUUChCR5hb2SFWl572YQXosUYqF6fR+r8vI/sptCQePKiGnGO72DfLpzpe3vwgRa/
X-Gm-Message-State: AOJu0Yw3K96rFNIHVJhKaxgbSwIRY/5z7auEOLcRfhMobLrW357tO6Ii
	e39Gi4djUCduyZU1uMv25+eTNtFjtu8Nvl6ImKLH7/5hAF4tuhLY3CzuR1TSh0Yyir7uFg1BrLt
	+fI5DudsZEJbM2mw9GLY2aDASUmjNavxbpCU2voGTDzbykArxO19yCCk=
X-Google-Smtp-Source: AGHT+IF5vyONmiDcpL1Vn1ikfQ9FuJdcA7AQfBqFl0c9bGxvp4BtLQVTyajhYTtMfn8Ff5AgREPlf6px3j7XUvVzCm5vX4mikeym
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c261:0:b0:374:a12c:30e0 with SMTP id
 e9e14a558f8ab-374b1f47739mr473255ab.3.1717543564732; Tue, 04 Jun 2024
 16:26:04 -0700 (PDT)
Date: Tue, 04 Jun 2024 16:26:04 -0700
In-Reply-To: <0000000000003d63410605a18363@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000100905061a18c63a@google.com>
Subject: Re: [syzbot] [usb?] [input?] INFO: task hung in __input_unregister_device
 (5)
From: syzbot <syzbot+78e2288f58b881ed3c45@syzkaller.appspotmail.com>
To: Henk.Vergonet@gmail.com, dmitry.torokhov@gmail.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux1394-devel@lists.sourceforge.net, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, o-takashi@sakamocchi.jp, ricardo@marliere.net, 
	rostedt@goodmis.org, rydberg@bitmath.org, syzkaller-bugs@googlegroups.com, 
	usbb2k-api-dev@nongnu.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 6b0b708f12d18f9cccfb1c418bea59fcbff8798c
Author: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date:   Wed May 1 07:32:38 2024 +0000

    firewire: core: add tracepoint event for handling bus reset

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14969a16980000
start commit:   e0cce98fe279 Merge tag 'tpmdd-next-6.10-rc2' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12969a16980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=238430243a58f702
dashboard link: https://syzkaller.appspot.com/bug?extid=78e2288f58b881ed3c45
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1318e162980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122e8eaa980000

Reported-by: syzbot+78e2288f58b881ed3c45@syzkaller.appspotmail.com
Fixes: 6b0b708f12d1 ("firewire: core: add tracepoint event for handling bus reset")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
