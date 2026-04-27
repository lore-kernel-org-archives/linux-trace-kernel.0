Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE1C28C5B1
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Apr 2026 08:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777280162; cv=none; b=Np9Lf9zeUjAxU28OdweMO70fbXkeUihAdpdFoyIC1AQPKGY9TXDrx7M3DC3mncEGLx1eaFljXLgDHFwnOGgq0ZGc0JkxgtAR9+mzS93kaA0eIsJ1n0SVd7no+kgqRlyd45PO6bjQ5EI9mLa/fgzHX2WlUVRIKm25fyuz+PfqzG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777280162; c=relaxed/simple;
	bh=e0ZEwjP6zD/rHV0Vqf4IhTgvBZ9ZV3aiRT8Rjtw6vew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=D83Ul3mkHvJpOaBB6Gs+5AGo7cEZkvlTimU7q59Xay/zVDR53mhmoLUJY5z2XIzO7XXba1rMhi4mqP6m2LxXD/S26ssYXZiEXbMKYfxEagkDsFLXESBrXnZc02c7w71FhVfSFAh6zr1kydw0oAGo1mexPriZElPHQ/94rsl/6C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bo7znAPh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bo7znAPh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777280160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdy7/E7tkeTBGH0DMuZvkxgqLNb/8QzaFC1QjP7ThlA=;
	b=Bo7znAPh7b5jhi5RPPWa6rBLShDuaM6XUA06Emi/ux4VcxZ4x2mGyITkuSC/KAlA3g3AX/
	0KzvK4N3CWzNJlWR9lbvljqbBjkNbcA4U1Nhxa/E4xSzLZX1j6fjoTeCi3CisBLtmhKwwJ
	oiEKYf80ZktNJ2szVI0DbYs3SCE3oEs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-A77rpIBbOyeDLZquVehGew-1; Mon,
 27 Apr 2026 04:55:58 -0400
X-MC-Unique: A77rpIBbOyeDLZquVehGew-1
X-Mimecast-MFC-AGG-ID: A77rpIBbOyeDLZquVehGew_1777280156
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0908119560B4;
	Mon, 27 Apr 2026 08:55:56 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ED2DC1800352;
	Mon, 27 Apr 2026 08:55:52 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: rdunlap@infradead.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: matteo.martelli@codethink.co.uk,
	skhan@linuxfoundation.org
Subject: [PATCH] Documentation/rv: Replace stale website link
Date: Mon, 27 Apr 2026 10:55:24 +0200
Message-ID: <20260427085526.111835-1-gmonaco@redhat.com>
In-Reply-To: <b845c448-1655-4860-9b6d-93d6f8426740@infradead.org>
References: <b845c448-1655-4860-9b6d-93d6f8426740@infradead.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: ZCiVkSpjJ38vNQkK-AkUrSKB6rwCG2YuLN8r18heeyM_1777280156
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The sched monitor page was linking to Daniel's website which is now
down. The main purpose of the link was to point to a source for the
models from the original author and that can be found also in his
published paper.

Replace the link with a reference to Daniel's "A thread synchronization
model for the PREEMPT_RT Linux kernel" which can be found online and
includes the models definitions as well as the work behind them (not the
original patches but since they're based on a 5.0 kernel and are mostly
included upstream, there's little value in keeping them in the docs).

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 Documentation/trace/rv/monitor_sched.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/rv/monitor_sched.rst b/Documentation/trace/rv/monitor_sched.rst
index 0b96d6e147c6..661171bd7c5e 100644
--- a/Documentation/trace/rv/monitor_sched.rst
+++ b/Documentation/trace/rv/monitor_sched.rst
@@ -365,4 +365,4 @@ constraints when processing the events::
 References
 ----------
 
-[1] - https://bristot.me/linux-task-model
+[1] - Daniel Bristot de Oliveira et al.: A thread synchronization model for the PREEMPT_RT Linux kernel, J. Syst. Archit., 2020.

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.53.0

