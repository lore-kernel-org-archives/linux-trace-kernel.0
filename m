Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA8F296BD5
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772093890; cv=none; b=kXIWWgdQ9UGPF9L3g2KM/IzRRJpQ6bYNQZZtN/u4Hna1jdX/eLLTGScMY90llUX1QzpSKmtc3gNH7JtiMVzEDLCQ5Jj8cZ3DgS4QqAZIHnHuOmi2q99/W3mgwGx75pcslm+3RiOduWhboJoDPP6Hh060jbBJR2UZ6qJ4JChV0bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772093890; c=relaxed/simple;
	bh=efQVGwbnGlBI05neSL+BC/QoRz4dThqvq9y3pYBvMv4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IbO7xdneD83hK+Rh5Wuay0IxEx8AMb5/hrO5RnU1Ybua/szrmLoz+c8ES9o4jRXFlCz47aqfxuvdQdCkhUx/24rhZGdHdbblA4q0kBfL74WximVLpMDmJnwOYyfdvgWstheXVljKGlO2m77Uhc8XA/W0SJ3VXPm1kEIdky/f9jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-67999892f00so14878275eaf.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 00:18:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772093888; x=1772698688;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cRnHuYUKg12YCHG5J1r0u9+hl0pgAOWU4h2gM9MRh5g=;
        b=Vbe+hSOdKS4nfdYoI9qYBC2tOv6cqrokrhqp+J840YyLWqSFIAFkdVlpv/mGwrg62v
         cGl3/w9nbnyeRLaZFSfZzSPjUAOE56t9LWW4uD7MK7NsmLULtmNjzY7lFYHvhBJuc2Vk
         qiTugKRG4pR7CIjRXP7PkH31KH1YalLuCpobh2tpSoNC1StZpFadccRksC4r63wDtsOl
         Bc7gve6morASrc9oMuguzZjs6TExhSiYBEAetGS5Jb3d9j0UMb0AvMgIm5wY/ZW6twhM
         Z2gM5ZwKyezCgnogXn8VImv8InQ2fwTKicpa0e8fSXKRiEkRtNqlEp/64i7stvMSC4yU
         5+1w==
X-Forwarded-Encrypted: i=1; AJvYcCWphqHSyGHEZRV2GwUQych6AphpkvwRn1MUcrFos8Am+PpNSWOhykaFShG8/d6qVhRhuxwk6hNMYTNWFC0eLJUgjqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YybaMG01myat08owGZYak0kLclY5z2K7QUeMe65q7zfcMQ0cEQV
	B0N/J9qjGeeZD2C6uQPiAjFPVUfdI32EOCsCzhSuLOqR/MblOAcLTMrDn7tdU8FvNxLipc5pRvC
	3UbKWLSwexd5h4NoEK6n6sTCSyB5J+fmGW3UN8tf/X6irxQru+vRRNORf0/U=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1f03:b0:65f:6d6c:530e with SMTP id
 006d021491bc7-679ef9ac233mr1612350eaf.72.1772093888346; Thu, 26 Feb 2026
 00:18:08 -0800 (PST)
Date: Thu, 26 Feb 2026 00:18:08 -0800
In-Reply-To: <20260226080013.270883-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a001c0.a00a0220.21906d.00a3.GAE@google.com>
Subject: Re: [syzbot] [trace?] WARNING in tracing_buffers_mmap_close (3)
From: syzbot <syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com, wangqing7171@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: Bad rss-counter state

BUG: Bad rss-counter state mm:ffff888022363100 type:MM_FILEPAGES val:4 Comm:syz.0.17 Pid:6501


Tested on:

commit:         f4d0ec0a Merge tag 'erofs-for-7.0-rc2-fixes' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=158ac202580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af6ed0125ed44356
dashboard link: https://syzkaller.appspot.com/bug?extid=3b5dd2030fe08afdf65d
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10fe1b94580000

