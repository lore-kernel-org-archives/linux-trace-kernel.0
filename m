Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC5E34BA35
	for <linux-trace-kernel@vger.kernel.org>; Sun,  5 Oct 2025 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759673812; cv=none; b=CfuzTzROU/DD6EKp6ZDwnAgwvMLYy1BJIRz/53nZD7k7TTowICILC/zSsB28+ZSCNja/zw3gkqUXuvbaG/9mCVjKuPcN8IX9rc/r3OmrX1hHAg+/wzMaWj2wW/BIIOY48yErs+GtwBNWpRrRXcuhn87ZeRX0kNPzWzhCSRcqWnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759673812; c=relaxed/simple;
	bh=Kpvh2nr5GCO+3G4nJ7iokN5C+UPwy7b5oSVqyXPBoc4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=f62NciUB8fAMmJ7EPtKVQHB0tMjDTk9SU25LzN0EiQHA09WOWp8nWAg+UANmj6yCMkHxCbwXVqniGvIqg4PjUT7kxeu7EOXaj1T8iiuxKB3xLxss99iB8MfVrK0hhCfcGAOri47t9UOj3FcEqF5qyh+cjZzRvcMezG7Hn78VKyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42f6639fb22so13207595ab.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 05 Oct 2025 07:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759673810; x=1760278610;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kpvh2nr5GCO+3G4nJ7iokN5C+UPwy7b5oSVqyXPBoc4=;
        b=vzLKk4cjB5TDFFK9rZy3iZ5x60Xie9+CrSXOneMdu69r7KSr0sQOP9/KnRMxQ9Fi5C
         um04UHgILZUi3XyvCfCK45NkbNo1IwbC5KAqDLEDdDEw6hKSgyaZ6i3LF0e3i0wxjIpk
         BqG0GwVfMAerNRQ/9CadpUUU4JchS1vM1/Ko/a48Rox6Hw8sqUgvvBHMF63UKubdofHc
         W+ukeY00D0tmXhmH1OzHEUaOw383XHIRsiGzggh6y5MWDzbPBqSqrM7z6GWK5EnDtGVo
         Txtokao5IAM6KHwuA78Scy7mx+SOfQFh0bhKelaPeLL9xTSzLM7is1cGed4k3OBPuBVp
         LEeg==
X-Forwarded-Encrypted: i=1; AJvYcCVx7lYlRm5QvvR2PQfl/nbR2l4fuUIUevz8VHn9RTouxja1sG9b26EVb5bVP79DiNy1i5J3ymll/AgbN5qPzGYrZ6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOfspUcqneqEou0xH0DfOq6bqXje5q0go6xtbHyTLaTCKlWpc/
	2gEWLCkHYxj3brPtY0ufOiImv4jnv3mif/YSNRlDxudEBkz9JGo2qtpwxntKXaerMzN81xUX7+Y
	szaVUUr5pHQAjsC4Fy6/tAUgzlY4Fa5XCU3ERcqhYx5DJ22+mj/Pid8BpN5Y=
X-Google-Smtp-Source: AGHT+IFZV6lzP20VhsA0FUGsjRFTmsNcV1qMC7ZCqzj6D6Nu+ZPOcbotsjPkZUhNQT1zEFXZ6UuuHFSMKtqZg9IOD0Eclv9AouGA
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2581:b0:426:e20b:f5d4 with SMTP id
 e9e14a558f8ab-42e7ad16b0bmr121902455ab.10.1759673809944; Sun, 05 Oct 2025
 07:16:49 -0700 (PDT)
Date: Sun, 05 Oct 2025 07:16:49 -0700
In-Reply-To: <20251005141636.12405-1-ssranevjti@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e27dd1.a00a0220.102ee.012d.GAE@google.com>
Subject: Re: 
From: syzbot <syzbot+c530b4d95ec5cd4f33a7@syzkaller.appspotmail.com>
To: ssrane_b23@ee.vjti.ac.in
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	ssrane_b23@ee.vjti.ac.in, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test on: linux-next

This crash does not have a reproducer. I cannot test it.

>
>
