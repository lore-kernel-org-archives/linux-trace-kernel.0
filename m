Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB59B3F8236
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Jul 2026 09:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782898923; cv=none; b=huLzBA70ya2ixLQsh3vrM+lnlQUU39Hgf/MyDDYD7kYVwCQyoYDKrrYU+/7rInG+soF42cHmCVPx2CvoJHumewIDKk/J1aIn9ieK0iZ0O7FK9OMZgSQ8ttYUkHBJT+/8fgAmlxIVzJvXknNdbf9QeXlFg/xPwgmFwxKlalNmPvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782898923; c=relaxed/simple;
	bh=2j1IRHpiwZok/MEnRQi4ogpZUseqv09nvSMhfYas5x0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bYUUPiybUKY83sqRM2gTn9IlJR4nKYlzoBooZ29LWEiuAc3Eq9hmQdbbEyxTClWYM+PbtZAjuFpDUU53BViZYNVPtdoK4EQH26JpX7kBwvDXCjtcv/BgjSZSNKPVJfpd1sVhziesO7GE61HBkd1Kw8ldI1YhTunwTJb7vdqQ4w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-44aeefa1c36so185923fac.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Jul 2026 02:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782898921; x=1783503721;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XI1UC3NchGgUWEa+ZM1MdQWFERybFkFO5qS25F4LmEY=;
        b=RmnAv5LTLfycsPORgx+PrNd+BqbpRtmPrUkMMaV6Gmaz1s0vGw83NR+FY63zdkdDf7
         0QRSXTj4SABPP7dtTT0SGsxidNL37sm23jK/YT13ACGTe++l2RPG/k672pHx/3qiKVAu
         g5bGqAy+urwd0zZF5pWM98oL9m1vjVb3tSdtLQZrof3OLLUCRWwHiGzGfibqpon/Y5K4
         Q4YQvQi1wGrbaiTI4fNAF62PJiLgV4411dNPhRWIpiAyrVPicONi7dOkDzhr54redCOj
         Xk09FjjPfVnrnJHa+9lT+XMHgRQZfkHX+IYz7xK2xa/OC/UOmyM3MnF6JVPtPJKC2b2F
         xGXw==
X-Forwarded-Encrypted: i=1; AFNElJ+efyLs1dqWsbj+c8eenWKigjpmxVcdcpGFpYwRxvnFVsmj4gZMb99nexjb5DsOqIFc0dfQ9O2EmQ2zC2ppSlQQlo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySDDe2fIbY8jmv6XirAYIgOs+E579O1qUsWgsOJPDbWAgfYsNY
	J8hPDYsSr9rcPlalrODbEumBPNKl6ODWF0uOSd7BE9+M3IR+wgAKTfsdi+frQaElB+xnXv+ifDK
	oouCSPTeYzaD4OC8LsRPJiGs9n1HRvRS/OX6F1+iX6I9QAgAJvQ+Wl/fIfj8=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c1bb:b0:495:e6d4:8289 with SMTP id
 5614622812f47-4960ee43a16mr458732b6e.19.1782898920892; Wed, 01 Jul 2026
 02:42:00 -0700 (PDT)
Date: Wed, 01 Jul 2026 02:42:00 -0700
In-Reply-To: <akTZNgy1UPQdNcO_@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a44e0e8.61501845.2b2b6.0001.GAE@google.com>
Subject: Re: [syzbot] [trace?] general protection fault in mtree_load
From: syzbot <syzbot+61ce80689253f42e6d80@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mhiramat@kernel.org, mingo@redhat.com, oleg@redhat.com, olsajiri@gmail.com, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, tglx@kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+61ce80689253f42e6d80@syzkaller.appspotmail.com
Tested-by: syzbot+61ce80689253f42e6d80@syzkaller.appspotmail.com

Tested on:

commit:         665159e2 Merge tag 'probes-fixes-v7.2-rc1' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14f7b11c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9bf5d2bfae96234
dashboard link: https://syzkaller.appspot.com/bug?extid=61ce80689253f42e6d80
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1084b9fa580000

Note: testing is done by a robot and is best-effort only.
