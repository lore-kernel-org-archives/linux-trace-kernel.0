Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA2A3446B5
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 06:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772174104; cv=none; b=d/1xiitEMTjEPvXFX6lNPnIkM934TutDK2gvQJHPXalp48T09XGn8FTyAAS1PU3fkr7OqRMpFkT0PVIKlKgOjGxYuAfTAKxngbgpoP8j1pacqMUDwA1voiP6XBbqHny4E9u9ZuASCeGeEpnZt/90kg2+MRkki/4gwvBPvFNbie0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772174104; c=relaxed/simple;
	bh=QbBr3T2VQUA3HHZ2LwPcLmmPuGaEyaZBuNW4ygJx+IM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jjC8U41BOHRbBLj03IfTItWDEtEM0j5aF9zaExroQEA50H7veilaYgBjmqhxmcbkg2iew/zYQu6GV2BolwuMlVHvEH3zYw897agTkG+o6wDCPFsSV6j+SIoXc8FbPg13XRvoi/wWkog90VK0ZOg27Vw/s5IAa2WYd81QoLc4R9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7d18e95c658so34555392a34.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 22:35:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772174102; x=1772778902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JXTA2zqOAstIeMEAVIOcvwyKQP9PlV3vwMKXGuZAb4w=;
        b=NYKslHswoIqB0kMgl0OijVD5RRpnDQCc2ztWY0ncxV9RJCoGA51uH7CBClUE0Y6Msj
         d5rQjb0hiugNzkODo6sbAHmShf0tLu+ZZWcbTv5LtGnLgwJ5nZnmtQCO98RecJPgRDxL
         pjln8KSuIIP5gxJvqS9XTXB8EyxGwIH7wq3FiOqNI066nFibYGnYp3At3jFXk8S3HueB
         Q/cbjlWqNl79iGvo4NIy8c82TTlEdLi0Ut96n7FqwiIcyFTrZQ+ASo3vGL6TRtryRjLn
         jJccZPmdYH5S8nXQ45Wu71fFSpH9/irlN2wMYryk78c2+MpjCF/zTIwB0knFzp/8CGz/
         0XqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqnfo2bUrg+zyodY5OlDIf0+tN4U6XCseePNRCzITyrAxDNFeU4ryQbz3zExXKwcaveedqHTdLzS+JNZaU2Qbb8dI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3+d0NyX7mhDF7GW/2eW/VuvJr4C0XEA8BAKSGAJ9IaF9dOYol
	VRHjHF52m0nr4MVwc9SOoH8YA/vG04l8e9mXWukIe2VCzpQc0s2qTT8Ig/hYUeFXsUDTqw7yODs
	Ko9vnLe1AZNAk8dke97Ln32jGDMaxdI3QZur4cPx/z+wCUkz6KSqoWl3tEn8=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2293:b0:679:a9:9447 with SMTP id
 006d021491bc7-679fae16f08mr1309686eaf.27.1772174102529; Thu, 26 Feb 2026
 22:35:02 -0800 (PST)
Date: Thu, 26 Feb 2026 22:35:02 -0800
In-Reply-To: <20260227061759.1126681-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a13b16.050a0220.305b49.009c.GAE@google.com>
Subject: Re: [syzbot] [bpf?] [trace?] KASAN: slab-use-after-free Read in
 bpf_trace_run3 (2)
From: syzbot <syzbot+9ea7c90be2b24e189592@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, 
	mattbobrowski@google.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	wangqing7171@gmail.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
lost connection to test machine



Tested on:

commit:         a75cb869 Merge tag 'v7.0-rc1-ksmbd-server-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12e650ba580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=56150637ffd942dd
dashboard link: https://syzkaller.appspot.com/bug?extid=9ea7c90be2b24e189592
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1476755a580000

