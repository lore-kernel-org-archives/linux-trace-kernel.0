Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074D382889
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718025803; cv=none; b=Db2RvYsJl09fozy8+ihgep2pgm3+BQ7OqR1BNL22zy/F6QqlIjTD6KuPHqI/DymwGVdC5nB93qSY5IPJ9YOXQJiWS5frXIphW2K058VvZ+KzbO2xOJtpDp4naBbnjQ+TfwzPhkN2esnwF684wgeSKoELbVdskmFaLJd7U+tv/Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718025803; c=relaxed/simple;
	bh=YhHZtXtYOeqPDpUQzggSLYgS7dOxECQ9WBN80nvz9pU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BX0k330mNS0Yxawq+KdEYeMNyAzWkXLY07MzNnw9Vu8LolNytNRoQq98L75vn/7b7YHXrQA6HN135wM6te5PETLjbnkrtWCzl9xfDMwfK6RAUNriPfwKzjirTs7vAwZ73tv1NF+DxKx04oGcoCiHU1ArIZ7JWxs+y/gY3WvOKi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DjLqdik6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjLqdik6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718025800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=HZ01OIp6KO6+A3DggujUXEq6vyWDZMFmW9tQ8SBohTE=;
	b=DjLqdik6iUrNiIG51fPOAPwelL7x435X0IRuClojW+Uy9K1u+YF0fE/T5i4psNkeU0C8tz
	xCiCbNOX5uloemb4QO5A3xBFr5zL/aL9X58SZvpthTnEqsmQtVpzkggZT5n6p1M3MmEtjY
	9sGGcRZSDmH+yx3oVwqyc4D4lfjrseQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-9f1Rr8QsMCW28P4hg_Jl7w-1; Mon,
 10 Jun 2024 09:23:18 -0400
X-MC-Unique: 9f1Rr8QsMCW28P4hg_Jl7w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE0B81955D74;
	Mon, 10 Jun 2024 13:23:16 +0000 (UTC)
Received: from localhost (unknown [10.22.8.210])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C5F1B19560AB;
	Mon, 10 Jun 2024 13:23:15 +0000 (UTC)
Date: Mon, 10 Jun 2024 10:23:14 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH] rtla/osnoise: set the default threshold to 1us
Message-ID: <Zmb-QhiiiI6jM9To@uudg.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Change the default threshold for osnoise to 1us, so that any noise
equal or above this value is recorded. Let the user set a higher
threshold if necessary.

Suggested-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Reviewed-by: Clark Williams <williams@redhat.com>
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 Documentation/trace/osnoise-tracer.rst | 2 +-
 kernel/trace/trace_osnoise.c           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/osnoise-tracer.rst b/Documentation/trace/osnoise-tracer.rst
index 140ef2533d26a..a520adbd34765 100644
--- a/Documentation/trace/osnoise-tracer.rst
+++ b/Documentation/trace/osnoise-tracer.rst
@@ -108,7 +108,7 @@ The tracer has a set of options inside the osnoise directory, they are:
    option.
  - tracing_threshold: the minimum delta between two time() reads to be
    considered as noise, in us. When set to 0, the default value will
-   be used, which is currently 5 us.
+   be used, which is currently 1 us.
  - osnoise/options: a set of on/off options that can be enabled by
    writing the option name to the file or disabled by writing the option
    name preceded with the 'NO\_' prefix. For example, writing
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index a8e28f9b9271c..66a871553d4a1 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1444,9 +1444,9 @@ static int run_osnoise(void)
 	save_osn_sample_stats(osn_var, &s);
 
 	/*
-	 * if threshold is 0, use the default value of 5 us.
+	 * if threshold is 0, use the default value of 1 us.
 	 */
-	threshold = tracing_thresh ? : 5000;
+	threshold = tracing_thresh ? : 1000;
 
 	/*
 	 * Apply PREEMPT and IRQ disabled options.
-- 
2.45.2

