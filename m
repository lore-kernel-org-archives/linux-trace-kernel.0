Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4B41BE250
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728552836; cv=none; b=GSdHtCgAxu4uvKkLFQCRj66TTNzphHvt4uJ1Pv6BzZ7FRnS8D7x0pEVmmzkLqad6oBJ+XB4Shjyj3yWgZ2X/XYPC/uRxfovsHmTt37ONaeDUQEush7BVquKaU9MAjO7WKYJWprZjyWOBaGo1kzOPGx73ES8qa8zunUgUr1ZqnPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728552836; c=relaxed/simple;
	bh=UnKplElgkxqXlmdKt21RNbV4im801BH8jlMalCnJrxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OZhx4BZr9v8gqyriHLqDv9vT/8Y25ddGJuDarHc+XHMc3rUt024r/E8+B3kn69RnksvqSwWR9vJ5K1FqXvgpmnB9xNTqhpX+Z7pItv0wEj4P+FbogBxO1NZwUlk5CgAz/ie5DDqYqOLsECt030q2OVaIB4Z9kYOBxGG85lGdja8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JPfhXDYs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPfhXDYs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728552832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aVO3JGIa+LyNmHTe4s/0+9qfkW4GP8M1slNLwf55zUI=;
	b=JPfhXDYs8PrEkwA8K9RcD32+JU8kwBN58XZgrRg6q56z6puCLgQlk9+wt6TNlpoX8Orise
	ebFH2XAsqspq6yCzjFA4gtBC+sdfyESATQJic6xSXOPQSkvICLpOAnhrsEKs4cIi8PolHm
	NFGxkObMOVKcWY+ZCiPxfCae/zT156Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-hBCnLCXEPEKvoqMSB-UK8Q-1; Thu,
 10 Oct 2024 05:33:49 -0400
X-MC-Unique: hBCnLCXEPEKvoqMSB-UK8Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 646F81955F10;
	Thu, 10 Oct 2024 09:33:48 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.226.2])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2D8CB30001A2;
	Thu, 10 Oct 2024 09:33:45 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	jstancek@redhat.com,
	jforbes@redhat.com,
	ezulian@redhat.com,
	tglozar@redhat.com
Subject: [PATCH 2/2] tools/rtla: fix collision with glibc sched_attr/sched_set_attr
Date: Thu, 10 Oct 2024 11:32:59 +0200
Message-ID: <45c1f78d4f0e7f1b786443ffdd462d7670ec1634.1728552769.git.jstancek@redhat.com>
In-Reply-To: <c355dc9ad23470098d6a8d0f31fbd702551c9ea8.1728552769.git.jstancek@redhat.com>
References: <c355dc9ad23470098d6a8d0f31fbd702551c9ea8.1728552769.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

glibc commit 21571ca0d703 ("Linux: Add the sched_setattr
and sched_getattr functions") now also provides 'struct sched_attr'
and sched_setattr() which collide with the ones from rtla.

  In file included from src/trace.c:11:
  src/utils.h:49:8: error: redefinition of ‘struct sched_attr’
     49 | struct sched_attr {
        |        ^~~~~~~~~~
  In file included from /usr/include/bits/sched.h:60,
                   from /usr/include/sched.h:43,
                   from /usr/include/tracefs/tracefs.h:10,
                   from src/trace.c:4:
  /usr/include/linux/sched/types.h:98:8: note: originally defined here
     98 | struct sched_attr {
        |        ^~~~~~~~~~

Define 'struct sched_attr' conditionally, similar to what strace did:
  https://lore.kernel.org/all/20240930222913.3981407-1-raj.khem@gmail.com/
and rename rtla's version of sched_setattr() to avoid collision.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 tools/tracing/rtla/src/utils.c | 4 ++--
 tools/tracing/rtla/src/utils.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 05b2b3fc005e..c62044215a48 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -229,7 +229,7 @@ long parse_ns_duration(char *val)
 
 #define SCHED_DEADLINE		6
 
-static inline int sched_setattr(pid_t pid, const struct sched_attr *attr,
+static inline int rtla_sched_setattr(pid_t pid, const struct sched_attr *attr,
 				unsigned int flags) {
 	return syscall(__NR_sched_setattr, pid, attr, flags);
 }
@@ -239,7 +239,7 @@ int __set_sched_attr(int pid, struct sched_attr *attr)
 	int flags = 0;
 	int retval;
 
-	retval = sched_setattr(pid, attr, flags);
+	retval = rtla_sched_setattr(pid, attr, flags);
 	if (retval < 0) {
 		err_msg("Failed to set sched attributes to the pid %d: %s\n",
 			pid, strerror(errno));
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index d44513e6c66a..99c9cf81bcd0 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -46,6 +46,7 @@ update_sum(unsigned long long *a, unsigned long long *b)
 	*a += *b;
 }
 
+#ifndef SCHED_ATTR_SIZE_VER0
 struct sched_attr {
 	uint32_t size;
 	uint32_t sched_policy;
@@ -56,6 +57,7 @@ struct sched_attr {
 	uint64_t sched_deadline;
 	uint64_t sched_period;
 };
+#endif /* SCHED_ATTR_SIZE_VER0 */
 
 int parse_prio(char *arg, struct sched_attr *sched_param);
 int parse_cpu_set(char *cpu_list, cpu_set_t *set);
-- 
2.43.0

