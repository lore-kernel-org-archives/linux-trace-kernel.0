Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45C1466B5E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Jun 2026 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629135; cv=none; b=ZSb8hSskxfcapGBDBLRgQEGbAjDzIa1jaOuE8cMjZ9ZW+q6N/XqPkUQbIhQSqE/WPT48MLSmkdyFWqMos+eVyI6WLPKBYBbOfJZ1RPJPvyE9rWc0mIbpXJpEyfn7wVGfdAk6j27SBGrmhXNDONQ9+GWMXGieeVQl0oQmYFsjFCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629135; c=relaxed/simple;
	bh=7rEGOSr5GZg5GcXv8gEql7u7flizL0teEp8HjsGuvgs=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=DAUApyy+nvIxYp4tLaKqpjBMJ8rhGGRv8D8mKa2+yJNWwllGi/CLpymt5YOHxgmBa2BzZsXoXVFrZmO945C4d7l2cWzTQ+s4k/NjmCeoHs/GFZf0rnJitIg1SWf2g4gRpBBvdWuy4r9pTJy/t9J09qW8rGtIqtvemom9d4zpMgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QMryXaSc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMryXaSc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781629131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7rEGOSr5GZg5GcXv8gEql7u7flizL0teEp8HjsGuvgs=;
	b=QMryXaScjryXR3FjZ4BoKDTZa/keRyvhk8EnrM+SUhmBvtG0e+VCR7evZeL++tRxrv4+rN
	X3NXmt4yfDU5g9NqH60zj17N17MxyAKt0TQCXcaoiUPjr9uQ71Sf5ERWf+PA7rpw7WC2XL
	rmfHXBOfwwloPj2Ii45WZtBneksYX5s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-W-jX6sUhNZGkPoD9EjGi8g-1; Tue,
 16 Jun 2026 12:58:48 -0400
X-MC-Unique: W-jX6sUhNZGkPoD9EjGi8g-1
X-Mimecast-MFC-AGG-ID: W-jX6sUhNZGkPoD9EjGi8g_1781629126
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E0EA18001E3;
	Tue, 16 Jun 2026 16:58:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.50.44])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 996A31954126;
	Tue, 16 Jun 2026 16:58:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <67e9006d.050a0220.1547ec.0097.GAE@google.com>
References: <67e9006d.050a0220.1547ec.0097.GAE@google.com>
To: syzbot <syzbot+ab13429207fe1c8c92e8@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
    marc.dionne@auristor.com, mathieu.desnoyers@efficios.com,
    mhiramat@kernel.org, rostedt@goodmis.org,
    syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [afs?] WARNING: ODEBUG bug in delete_node (3)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 16 Jun 2026 17:58:40 +0100
Message-ID: <2150109.1781629120@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 6OuQNQjA3mpDJHhUzJ1nDKFRBnMQHjLrrZk60iQRGZk_1781629126
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2150108.1781629120.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 v7.1

