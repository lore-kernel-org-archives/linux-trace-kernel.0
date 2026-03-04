Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9287124DD15
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Mar 2026 04:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772597166; cv=none; b=JrnNlAtOtjtQPSLbgO88QgWr3cXANhbOOSV0l9jT0a77US4JsBilSPoibN+75dvErh6yl01UjHq3iPFzTIforSK4zaty6yTuYtg1EGNAEJbWTWVJl42J7COEWHQYrYfheQDEbdaX6JwyOGnxLNlZ4dgZebbJQ6KrVKu3/4gqYuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772597166; c=relaxed/simple;
	bh=E3yOXFpHFMVo1rQzne+t2fIYKkJ6q3EsFjm9i4zgg9Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=O2VZzUVPHy8R8K1N5nyrGf9jEr8HFUxK+jBpkJLb/qA8SIqrvbKEKMm5tzN7qSZlPh1TpInt8ar/WKTdiyG5vMEIahJp0SeVKzLWk9k6OpPv6oZ5z+XjLWRtamDs+WCD/+w3EKnrwr7+cLwzsZRujVsq1pGYIGbaQzlVGIrm2G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-679862e4413so107690617eaf.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Mar 2026 20:06:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772597164; x=1773201964;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojGB38lgnWdZk41nYibXtYMqngkgjRaH3FwY1gAyu8g=;
        b=Kp30ru7zyZrhoN28ZtM40k4096y7XSYWZ/wHMz3vq2kEVpQSTfL4xoc73j9xCx1nDW
         D8ApHmWgj8ebAAhvI0HtOFp/jdV/ZIbtpO8G5UXbl2w0CYgmaRW4dENnf6/59f1rjTf1
         VwJAnmwh1rjEuYJKafkVeATZWPj0+MT4aKrj5CGkUnT9fZ3kgAu6dJ6YkQog8n7UOoYj
         vi+mKBVap2NUnDAxnHeHqQ+VXe1rulF/1lxhLunO2KU95ecxQeTeOrW1VSGU2DyHvhQZ
         Vpc1qrhLzk3so4EIxdg4K67oc2+V+ECj+03iUIfjXi5gi1cAKyO9YnD4kueoz2QDd9Rb
         GHBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUDvuQwU58KZRgtDEa/wTchmx2zv/KzCcH6nZEiMpbBhLimI7ivX0FVD7wdlRsxlxRVoSGo75lMRJ3QNpLXGRpR1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyuHyjZQ2wt/dfjgyi0tSyYB9aSDqv/D/yDrPQX/Dyui7tyFMD
	rX41X4PzS58b99pdhQ+E35hfrh84GKi0HFe4I0t+iFJPKwJlERteHZRZ6Ffg6GbrexoftjubUp8
	WaL367vFYu4PAxc1lAGgdcz+ISOoRMt+P5Wj5WFj508N2TkYjY9sZTpmUwN4=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1795:b0:679:9873:5e86 with SMTP id
 006d021491bc7-67b1e90f718mr518319eaf.61.1772597164625; Tue, 03 Mar 2026
 20:06:04 -0800 (PST)
Date: Tue, 03 Mar 2026 20:06:04 -0800
In-Reply-To: <20260304033822.107697-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a7afac.a70a0220.135158.000f.GAE@google.com>
Subject: Re: [syzbot] [bpf?] [trace?] KASAN: slab-use-after-free Read in bpf_trace_run9
From: syzbot <syzbot+b4c5ad098c821bf8d8bc@syzkaller.appspotmail.com>
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

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b4c5ad098c821bf8d8bc@syzkaller.appspotmail.com
Tested-by: syzbot+b4c5ad098c821bf8d8bc@syzkaller.appspotmail.com

Tested on:

commit:         0031c068 Merge tag 'cgroup-for-7.0-rc2-fixes' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1434f0ba580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c5c49ee0942d1cdb
dashboard link: https://syzkaller.appspot.com/bug?extid=b4c5ad098c821bf8d8bc
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17e5bb5a580000

Note: testing is done by a robot and is best-effort only.
