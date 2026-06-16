Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB5037B02A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Jun 2026 20:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781641745; cv=none; b=mlDVAU1Ow5Q8qUy8nAlNVdmMnM98wUK381JRHFl/aIYd3hGkGltigZMW/77YHD9ht6Dku3EcJb/hVmu3SHVogL2Acg4FU5Whe3yz4wKJJBtNilyCfHGSeJJ17xIsGsidxtwJ7skcfT5UTkMtc3WJfIwUIuHqbKxNcU9cJhvzL8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781641745; c=relaxed/simple;
	bh=arcYw3OwXWCsvLCVu8HJmx2o3gmPdPFiqfg9RKv1gh0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dDu5bhedqNjQvhEVMh8S2XvoUx/dT2sfW96RtwB65blRT4a8dzeGQBA6/g3BORBTp2l2POtRQessBk/KgZvJoo2uBsyOvyizvDasXl7Rcj7DOIq0yZrGp+g9BslCZhR6S87sbIOx+gmR8VGOrRrWV4XPsdn+cYIdjps48UGuYrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4863abb79b0so393010b6e.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Jun 2026 13:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781641743; x=1782246543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CA3bNGRiJqCprgPl82Gah1Y2j6nSfQhssCw8wK0/WSU=;
        b=R4+eB0u7SFgTFA3tBbA56HIAT4A/+tLGlAnrUYXRFM/HMKAFSBYywGtNEa2maFfsLT
         esBoLvDZfnGZ5oEBjWZAClQj4u3M+gDUMcbqiK6u+qCRu3q37OBCHt4OnkWwtzbrB737
         ZZrfKDVPxZHlJ+TmUAg3Eg7Q52OxNlT9OkY3gh4Da8ZALE3dcU6TFpe84AhqEv0q9NPw
         LIJRHeEWqawRQBZkJk2QMz6++rVHuvgzx86GtEQSxjbOWxLkH981V6SC2JhLn6IkjHS+
         2IK8nSXgX6NpRUqxNflHZV1ImCmORe3hTcjm1B5V9g1RihDU8zwnFuNUxwbo/NxqYi9J
         n5JQ==
X-Forwarded-Encrypted: i=1; AFNElJ+oY03YZP7Wj/1qKHKDyQd8pOc/Q6Te6bA5kt+LK6cW/1XOFzzYlTtLbqSwVX1t82fr3dX3ikVnxUPNTMbI0rOxf2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHVh4vlrajTOjMC2GTp8/4PUmJM644tU9ucmrdu3vXE89egkc+
	gRRO4pJdXAB5ud+TjbFGXvxQDkACAYP9GeMsPt3cBo5PPwcg6iqYodI7ll+ZlEPbLcGofD9w6pg
	9DCeAcNGf6OWp1KsQBLb+QelGLSRd1XbR8yTUVQiNnIWbF18HHi4mVPs1GwY=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1819:b0:450:b249:71bb with SMTP id
 5614622812f47-489462be144mr158041b6e.19.1781641743114; Tue, 16 Jun 2026
 13:29:03 -0700 (PDT)
Date: Tue, 16 Jun 2026 13:29:03 -0700
In-Reply-To: <2150109.1781629120@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a31b20f.d1b4d54b.11ef78.002c.GAE@google.com>
Subject: Re: [syzbot] [afs] WARNING: ODEBUG bug in delete_node (3)
From: syzbot <syzbot+ab13429207fe1c8c92e8@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	marc.dionne@auristor.com, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
lost connection to test machine



Tested on:

commit:         8cd9520d Linux 7.1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v7.1
console output: https://syzkaller.appspot.com/x/log.txt?x=17026986580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=115afb95b0e6f56a
dashboard link: https://syzkaller.appspot.com/bug?extid=ab13429207fe1c8c92e8
compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6

Note: no patches were applied.
