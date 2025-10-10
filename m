Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2DB269D06
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760085294; cv=none; b=Thvp0U2vtfsLZZiBRktz8wEZLw1MlXfb3z3mbZPGNJGUoGPjrgwFLPu3kR3pjOsHKCY84JSsWr06cSe63ClgLFcSBpRU1bXrEq3sWxtVYxRcWmyT+SK9YUR3Y0DPIe4f7qRk0jX4A8WbEm7gsNL0XsJcv4vRM4j53nyIfA4k3SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760085294; c=relaxed/simple;
	bh=JUyAprN4RK+PNE7+uyOPEMkyc7B/aIwWA1SfQi/iwCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZhaN2cSxy01l7zptSwpUf0qeNgHYs8GhO09+hJFbUFpM99I77imkFenXC8cztDsFdJ0qQuecPKxKtPuBIPcxrdGHZMPR8W1OQdLfMvJ6kNwJ+i26/h8LpE+AskuicpDwVs0OrwvgWx36YKIzrNIkl4X8qEPEYMGsytqxbCfYgJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UVD1Ddxp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVD1Ddxp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760085291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nn+DENTjXH3CTbperAPV+HFXnO5s8m2BWZ5q37SQP+8=;
	b=UVD1DdxphS8LTPpjam4KzEU3rI8VGeSkjh3A1U4UKkPTQEE/XoJSYCaK5ys4whm85xIWmh
	YSe/ZfcnDjRFZ6RzqoyBkYAqKReh0nCfsAAwirDwFfqFhzF4n2xrvSqjPNRSGQSnI6LIm9
	67TiUAjI0TPvU6T8Tnt70TcaGdA87pY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-ZP_35s5xNguIhJr5YyTt-w-1; Fri,
 10 Oct 2025 04:34:48 -0400
X-MC-Unique: ZP_35s5xNguIhJr5YyTt-w-1
X-Mimecast-MFC-AGG-ID: ZP_35s5xNguIhJr5YyTt-w_1760085287
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05DB619560AF;
	Fri, 10 Oct 2025 08:34:47 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.197])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2D01419560BB;
	Fri, 10 Oct 2025 08:34:41 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Attila Fazekas <afazekas@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 7/9] Documentation/rtla: Mention default cgroup state
Date: Fri, 10 Oct 2025 10:33:36 +0200
Message-ID: <20251010083338.478961-8-tglozar@redhat.com>
In-Reply-To: <20251010083338.478961-1-tglozar@redhat.com>
References: <20251010083338.478961-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The RTLA option -C/--cgroup is used to set a cgroup for workload
threads. This is either a specific cgroup, if passed an argument, or
rtla's cgroup, if no argument is given.

Expand the documentation of the -C option to also include the
information about the cgroup settings when the option is not specified.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 Documentation/tools/rtla/common_options.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/tools/rtla/common_options.txt b/Documentation/tools/rtla/common_options.txt
index b842f065c8f6..26e94d291a70 100644
--- a/Documentation/tools/rtla/common_options.txt
+++ b/Documentation/tools/rtla/common_options.txt
@@ -48,6 +48,8 @@
 
         Set a *cgroup* to the tracer's threads. If the **-C** option is passed without arguments, the tracer's thread will inherit **rtla**'s *cgroup*. Otherwise, the threads will be placed on the *cgroup* passed to the option.
 
+        If not set, the behavior differs between workload types. User workloads created by rtla will inherit rtla's cgroup. Kernel workloads are assigned the root cgroup.
+
 **--warm-up** *s*
 
         After starting the workload, let it run for *s* seconds before starting collecting the data, allowing the system to warm-up. Statistical data generated during warm-up is discarded.
-- 
2.51.0

