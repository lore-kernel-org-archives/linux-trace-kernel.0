Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C3F25760
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106622; cv=none; b=FrqjDtuIWdU/zIAHINGFMl1dtfETTaSEg9eXrxV8ct/uMNtFjj0lWHHjJ3ZKTOkoLIHD7RslwmUYTLGjSXwY9RkzALIffEcykYTmlRXU1X+TBq5r3YDqsrz8RcKdvSx/2zDi2VlrvEQT6Duu3c18n8s9j9ZYPv7S7Am9U+iNZ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106622; c=relaxed/simple;
	bh=HBRK43gP2055T0s0GSexwoAa/3kH3YdJNWxa61o9aBs=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Dw0Gm43MXhiCOxNqSyVRh7T20nUfMxaYDwlO+IpO1RN7+oLC9X11rPcH5F3bPRYOOs/57j/MTsT2DSPci7Sef0Eufwc6Xi+ncgoIeq3B9xJYbfKGH5Vfp1o+UxAJPkvbEzR3aqzx3HRTQN8mPaJlyfF8aUOCZbRl1Z3vNaOt+HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W7GDcLEp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7GDcLEp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753106617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HBRK43gP2055T0s0GSexwoAa/3kH3YdJNWxa61o9aBs=;
	b=W7GDcLEpYTy4BRgLL0k55R7WbDNf35PzetkmKoCCr5Y3GKOBUZEL8sB4ybiAauE2+fNujv
	YMKhBkc1zPSfOD4p+z7Nf0G+u2xFawjRSJz7pEhT2vYISzOP1vrPoETBzB/76Ujc1rcmj4
	PomqBFNgMYrFBb6hvnQybeP8BgoefOA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-xkl3hcltPtKIOZ1NxAP0Hg-1; Mon,
 21 Jul 2025 10:03:33 -0400
X-MC-Unique: xkl3hcltPtKIOZ1NxAP0Hg-1
X-Mimecast-MFC-AGG-ID: xkl3hcltPtKIOZ1NxAP0Hg_1753106612
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 763A61800C39;
	Mon, 21 Jul 2025 14:03:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD4921800D82;
	Mon, 21 Jul 2025 14:03:28 +0000 (UTC)
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
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4118022.1753106607.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Jul 2025 15:03:27 +0100
Message-ID: <4118023.1753106607@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master

