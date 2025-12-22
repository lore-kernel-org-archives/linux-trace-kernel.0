Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B794D2DAFA1
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Dec 2025 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766408863; cv=none; b=jzY+2gG7cz5fZeuox73tEOEDskC4xbP9PwZjP8mXLmOi6JDZQ/BsEPltDnaHzaE0biU9bdzGXyuA/mpRgHfCeTb9v/mK0IMCZUnboLflnH+sFDJydFhe0FhSFHhX9tbLzTUVRM59qmBHPG889VJ7FS38TzIDl+SEeevgkmPXB40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766408863; c=relaxed/simple;
	bh=tm3JxcWLT5OFtlbOGY1o1PSfvPjuOVONj6aRCMCODo8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gVsiYPSYT98eTQj9C6nTUohIfh0/rjTY8WrarcPXJ9/WeAGVNjprHlG2McumedOC+wnagNxWU4doWaxisrRybEUpSb0NyNzY3oInw8KCuVtjjX7Rwd4WBzL9wBMu413INrZ6A13G+ySmwp5hBUmW0vhP/E9vU5ZOjAVnbvvz/Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7c7028db074so8733336a34.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Dec 2025 05:07:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766408860; x=1767013660;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tI787K9M7nZLFiZ4uyp8OT5S/tosrT3hxk1rZYHI0Rg=;
        b=YxV51oGwxC3Yff317LVYkq7Zrqhz8YBXeQkhwhRtAQeYJlSsnWVamlE0InlnseFS8G
         RhoiCfC6wgnQyrzthwD7aZerl7YdzclPNRyHXl10zGByTL8hJ46li4KsSHHZikUj9A9j
         0Dgxz5//fAFc83nLJ9O0hCUYr7fzGLYz2QtzyP2xTASKPyFqVGAXT+QmRaGj9n8tTbuS
         foMX+v1E9Rn3QAUBabeHG1pQt7m1ZLMadCqR2CRucn6Pe4aCVxtkxDq/n0oILM5tMnCU
         ydvdrJzWhwX7IsJf5WWrv7zD9CXz6PZPuxYgPnErw8vOU3ZZtH/USigSfpxiZRvFws0c
         17SA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ4NJ9jFOZd1mQ4Q73j/jzKjw03nKxdNX1YT5oOOQhK6LT8xDUOIYMl21O4oj2Yu7RBn+a8ggXenBae+ZaDgzsus0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJAzUFuo7M9OnbztlNq0e+6ttVksghq9gadBiGdjo6N5QBItje
	62mMDv9dwrRGjhsm6Q9PiB4lrBAqJMeLcOg2rPdR5fpTKWTmJootOZmWF+ntuKnWwNHC4Q3chwX
	7SrUYdsX/LCJwPczB9Iuqajl3OwXhWIwjDEJoorDP5DCSbucG0zODQXQ0JA0=
X-Google-Smtp-Source: AGHT+IHIFJj4OSkLIPhusxKQKWiQ1P8WVsf89QqZM4Fnj7wdbP7oO2G2pRuqsdnhor5lApmoDc6mi6ufXOITryW1y2bUlj/0x1Rd
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c9f:b0:65d:141d:9e1e with SMTP id
 006d021491bc7-65d141da0edmr3603264eaf.43.1766408860617; Mon, 22 Dec 2025
 05:07:40 -0800 (PST)
Date: Mon, 22 Dec 2025 05:07:40 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6949429c.a70a0220.25eec0.008b.GAE@google.com>
Subject: [syzbot] Monthly trace report (Dec 2025)
From: syzbot <syzbot+list200b2ab75a031b907b1b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mhiramat@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello trace maintainers/developers,

This is a 31-day syzbot report for the trace subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/trace

During the period, 0 new issues were detected and 1 were fixed.
In total, 12 issues are still open and 62 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 101     Yes   WARNING in blk_register_tracepoints
                  https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
<2> 92      Yes   WARNING in tracepoint_probe_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=a1d25e53cd4a10f7f2d3
<3> 65      Yes   INFO: task hung in blk_trace_ioctl (4)
                  https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
<4> 61      Yes   INFO: task hung in blk_trace_remove (2)
                  https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562
<5> 22      Yes   WARNING in get_probe_ref
                  https://syzkaller.appspot.com/bug?extid=8672dcb9d10011c0a160
<6> 11      Yes   INFO: task hung in blk_trace_setup (4)
                  https://syzkaller.appspot.com/bug?extid=9c1ebb9957045e00ac63

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
