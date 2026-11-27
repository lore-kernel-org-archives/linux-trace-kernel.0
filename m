Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793591;
	b=TKkDecBMj6dF1EDbYL2Bi08rIg9G8spiPCsmocLbjWxLXDy4jTUfVfvxbKuPjx72RdRZ
	 ca/F/JJvi7t1RZ4rC+Ojbu27/n0NDYNIxZL1fYBCp+U/wSqBdqTSLl+dWuoZ7Q/E4kDFw
	 1VjzihVjL8tJeeTIf6V6Y/fA9S8V7Pzb+4K8+2u3fBri9ue7G+VnkY8wPqvdtnCmNAlqM
	 kHElaC3xa9cX1lvHDPJcIkiTaEwJ7wV4jpxghMSpn+5ySbz2kvgR1uMcpDdI9PNIZd7uz
	 UlLj5v5gOhAhnuwhxbmeivdBE7tWrJbSh6f7q0AYCtV56PsGFrvESZIHv50C2vpV6cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793591;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=jpxHPq5Ayx7L6RUhWCoq5VM2FQHeTfA9tcD2t4SkdD4=;
	b=n3Jq4RboOdyYX66UqYipgqPYOlv0kqgsU3MrgHSgZ2JXs8qVKYBk4d92YdqV0yll9wtH
	 3m07jGrlMAcSkt9gw7o1IC6vESJOusoYOq8AqPNgqHelHFRon/iJ19iY2lbyUph/o0hqB
	 Ymsbs/Ko3Be10AKezj/zUTfrbN1yNIEGW1NG7UStFKLv9nLFwxptFk173mVCT2LyK2JXK
	 28Cm/p2SzHWM9w5YG5bxhncz8wW+gG03ZM0ruvtn93GjHzzKSyshXFwD/oOK8cjGRpHpP
	 NQ11fKi3q8/YGkAQMkpwCkEDZJgLhATupAXLzg/bzoiKoAyVV9WuF9rQYadYBGociSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XKqsHe5D;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66E5606A327
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 15:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A66E5606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XKqsHe5D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795793589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jpxHPq5Ayx7L6RUhWCoq5VM2FQHeTfA9tcD2t4SkdD4=;
	b=XKqsHe5DPyDJFD7xIxIAOfrzYsFtb5jHOK5gxk6C01P1NlKTDEUgy3717k3gZCC01BuC5T
	nBAgdcfrNWARpa11fngDZxZI/r7ROCgZ2DH4VJ5M4IErepjRLTPSRtZBsEJEDL6YWtr4YW
	twIidWAN+UWhgeon9CoQLCgEXuGfpSs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-ib6JfiPrPqOFsGxPn0vksQ-1; Fri,
 27 Nov 2026 15:33:08 +0000
X-MC-Unique: ib6JfiPrPqOFsGxPn0vksQ-1
X-Mimecast-MFC-AGG-ID: ib6JfiPrPqOFsGxPn0vksQ_1795793587
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3206F1954222;
	Fri, 27 Nov 2026 15:33:07 +0000 (UTC)
Received: from tglozar-thinkpadt14gen5.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2B1921955F01;
	Fri, 27 Nov 2026 15:33:04 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: [RFC PATCH 04/10] Documentation/rtla: Document aa action
Date: Fri, 27 Nov 2026 16:32:00 +0100
Message-ID: <20261127153206.134322-5-tglozar@redhat.com>
In-Reply-To: <20261127153206.134322-1-tglozar@redhat.com>
References: <20261127153206.134322-1-tglozar@redhat.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VCHbbbitdArvYwbPW0v5miPuBJ86Y4hhgQuOEeM1d8s_1795793587
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add the new "aa" action to the list of actions under the --on-threshold
option and clarify that it replaces the default auto-analysis done at
the end of the measurement.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 Documentation/tools/rtla/common_options.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/tools/rtla/common_options.txt b/Documentation/tools/rtla/common_options.txt
index 6bf0f86393333..01e8a5bd3553a 100644
--- a/Documentation/tools/rtla/common_options.txt
+++ b/Documentation/tools/rtla/common_options.txt
@@ -94,6 +94,15 @@
           the trace being saved multiple times, and --no-trace will not disable trace
           output when enabled through this option.
 
+        - *aa*
+
+          Triggers auto-analysis of the measured latency.
+
+          Selecting this action skips the auto-analysis done by default at the end
+          of measurement when a latency threshold is hit.
+
+          This action is only supported with timerlat tools.
+
         - *signal,num=<sig>,pid=<pid>*
 
           Sends signal to process. "parent" might be specified in place of pid to target
@@ -134,6 +143,9 @@
         See the documentation for **--on-threshold** for the list of supported actions, with
         the exception that *continue* has no effect.
 
+        If **--on-end aa** triggers without a latency spike having caused the
+        end of tracing, the action is ignored.
+
         Example:
 
         $ rtla |tool| -d 5s --on-end trace
-- 
2.56.1

