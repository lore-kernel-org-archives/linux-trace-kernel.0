Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB1A1F9F47
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Oct 2025 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759859105; cv=none; b=jcjb0RMqC5uByG5AA+D3x1C+4P/xbces6KdIr9+jhEkOehRqbvswAutmZVMp2ItFl3Gpxgu2E2NE5qgfkg9Y6zJtmY+mtzL/RPv5/5mUH5yDH6C+R4kylOK2pbzygodkMMupYjDvTBNa72UmmkVP57PSUV1PJdPPIzw4E/AIvK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759859105; c=relaxed/simple;
	bh=iHVSASOMpEg/He/hoeH9kIEP14zS1QbDrqdwO1rPbLA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PP2U/bEGN2h72Qnjmnx8AHcQcAUm/Xr41OKl8SufktVbXIJa0+NhikCaHztUnRHJssuox9anNVy0e0mQxxvH6oHLbZg+z1RXsAeneRpYK03qJkIKXTsRMQgBXk8n/MFnooyHmNsypqJd/O7asUo4aY4bmGAAuFRxeyOqhvv5h0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8870219dce3so691601439f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Oct 2025 10:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759859103; x=1760463903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQ8LwJ2kllcnIjhbSb8t8QQLy2sXIVFfw/qICKEG1sY=;
        b=kAF/Ly2TgeTHvz0XNpFPMjwvq/YxQCuwhpgC5mPRWK5lrEUG41fLoH0mOil/YK/vBw
         fY+sYYmSLUUAU8ZkCz/a4TSUOo2sbI3ST26kpV4hZc9/oK9CyJhtyTYGUostZtcaY1fw
         SEEhpNL9Fl0nnl0dRKsfNgT+dZeD2SgFAdMc8HkDRXM9+22cZ3VO8ZDOm0PI3dSXzujg
         rQgLn393N3mIlDtCwPwCOHVRTd15HoVm9jQXiLHfn18NbdenLJ6wyqm0o9lPmHH120ek
         PKSUZc982/TQy5XcC1xb59TH24IiKWUDNxPWCjV5IVRGU2dlPDfvdw+Y8nGtN2ddcEDS
         JlJw==
X-Forwarded-Encrypted: i=1; AJvYcCV+97tez6gow3pQuj0Cq+MbXqKJtgim41S/yRNW5vvfrpda+pf87X5nfubk4gO5rzpjzS+AK4gXUqxIpW7RqRDVQSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLjLsQtpeN9vOv/evs4k1/a2RmWVrFECymqH4R2OinsjQ1Z0/v
	DVM4e7V8bYBhBe6EZ7IAbTCE36FSRa880LX4XQk8B/4gYjGnYv4b5MB8l09DcinlIUIcEtaX6sd
	Vew2ext3dJtJvfFZDFtY7M8pQPJx++OUHAexTvaNUAgkxlYz7kJ5qIVXraOs=
X-Google-Smtp-Source: AGHT+IFSDH+Kx4nFTO1p/Mgi17M1eo4iFNiAqnoTP2PGFKpeamxueHtLoiP1elV9Re0bzLbxiLZOEJw3X6kx1ZTxkY0Eqb3HK7Hg
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d8f:b0:922:6c20:45ef with SMTP id
 ca18e2360f4ac-93bd18cbaa4mr17149539f.7.1759859102832; Tue, 07 Oct 2025
 10:45:02 -0700 (PDT)
Date: Tue, 07 Oct 2025 10:45:02 -0700
In-Reply-To: <20251007171256.20884-1-ankitkhushwaha.linux@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e5519e.a00a0220.298cc0.0482.GAE@google.com>
Subject: Re: [syzbot] [trace?] WARNING in tracing_buffers_mmap_close
From: syzbot <syzbot+ddc001b92c083dbf2b97@syzkaller.appspotmail.com>
To: ankitkhushwaha.linux@gmail.com, david.hunter.linux@gmail.com, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, rostedt@goodmis.org, skhan@linuxfoundation.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ddc001b92c083dbf2b97@syzkaller.appspotmail.com
Tested-by: syzbot+ddc001b92c083dbf2b97@syzkaller.appspotmail.com

Tested on:

commit:         4ff71af0 Merge tag 'net-6.17-rc8' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17676892580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=595e5938a1dd5b4e
dashboard link: https://syzkaller.appspot.com/bug?extid=ddc001b92c083dbf2b97
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1249d1e2580000

Note: testing is done by a robot and is best-effort only.
