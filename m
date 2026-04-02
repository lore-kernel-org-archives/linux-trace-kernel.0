Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF6C38F249
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Apr 2026 09:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775122013; cv=none; b=I0TqcJF/eDDsO8uuLHBBAvshuOSvkJEXSZvmVrljqsrCg48VN8ZdAUssf+4o0VMTjVNOjX7g09QnJA29oC+JisEljeMGHo3gi5Q/8XysDNoEelIft1oRUkoQwgWF5aI50Og0y0bMZx3+2fvJF992d0DacycyvW3jp78+xFBxsRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775122013; c=relaxed/simple;
	bh=fg9gtssW70rqBjzjZemwy81+H2Jd6oM+l/xkQy5zuS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYYg3jge3W33XOkzU3PC6IxihwbI7WV0JDwfYg+7QndgD7BPs2xBhySZFoVSXnUytWT4wumw2L+DpESZy0nuk4eg4FK2dHPWfIZGjXOZox3J+viL7Kk3yU3Ewn9f820btGJ2snTeKgdioOps+ZqQ+2zruZAzOhIhWdcRHj14P2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwjBuQCg; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwjBuQCg"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35d971fbcddso353175a91.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Apr 2026 02:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775122004; x=1775726804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcS6+ltlajemy60nMyxmGDon25GNRE0B5Cl/4uAqhyI=;
        b=NwjBuQCg+b08pUjtJ4kKR6QxL3EofbU+P1etAguRY5SkyGw65JUgXjogeGYGpXAacV
         N2UDTdgGH9KEx4RsQJ1sx654k6ZKfMOxAssT7RmifOy3UF7MmhNdppcmSe5eu+ycS92o
         VgOuVvYdMw/Qjz7qLB1LosBadeghQhTHXkyyxKSWWIuFyYiO0rIBYNxWYcLy87KijYqF
         J6nEjtHYuHfygTZF4dGZK9wZruYwpNEieAuNUD6Z+F7V1AjJCLD9+5dKfMHjG+E4SvFt
         1bP2XQy4J2We3hdie9ogx7N266tIguejWg+kF8jS+kL/Kz0Wx3pg2JQ8H2GuBiSyMMRy
         BtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775122004; x=1775726804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CcS6+ltlajemy60nMyxmGDon25GNRE0B5Cl/4uAqhyI=;
        b=Qa2mc23Qt0lYvMakxIxY83xcvBfSDjS+FWqvWYLKg7fK3NfJbwrcXi5yoIB5aLoF03
         0mK2shqfUBGF8UwrKW/+9yUfct/vkJk2mneGrDpla6hmZ6xKJ3zAXEo7gfF2fdmKkgff
         ec5knwjBDfz9FEDypvpboF+BSyJ0+8PpTM/ueQ3lK1ol2B+ESmKeaaQ66zIjAVu7RO1j
         RUm5VyGfs3Zdp1hKRdXyOOQGBIvtE9TLsvutpBFfjXtWwbt3PN5istsE5Zr3elL3uuM7
         DPR9fC90BUmpL/g5XPm9LhY8c9ghhZnGX/01WykTEHRDlVbBxTLDuSKOh3Q/PpohssBP
         2nzA==
X-Forwarded-Encrypted: i=1; AJvYcCWxgEsk5hzVLINwn7bnNlFxqPj3eh2jsfqH96khstXI6aojCOW0tZD6GgQkN+rUiaicMg0BnXnv+HQShXWFa3KCWU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLcKQmlCnVmN/HYyeIwv1LzudJmF6/YDJ/BHbNLs+wAqkME3pS
	eazvqLMRzKb+llKAcDNX443FBtnADpPK0c5qGVhMtng7NEJ5VN8ftl3f
X-Gm-Gg: AeBDieurLXF3gWXrcjaK9SOgNlWDd9uWNO+sD1VLRSopUg0k9R9FBCfeoOjtzDM0EN1
	cmvASMSwGfQ1gdJXa0gEB7wyLGpsPTvyNIwTECwacoNZWPH2loQVfW4Yaa4DVIi8+vf3Z9HYfDo
	fwihva7Kny1KPlIskuZto20UnoOc6uLDoM+Y7xbX8DtU/TYByLCZrbwWf3S3cmTHYCYTW7mw+Pr
	bfKDde6HGcf3QotK2i+DrPO2ozYEJdKpgHLeQjzK49w71jK3JduWWNF42jjR+3ElhZTuiyX0tcP
	mtKDmm+AbRCTyIeDQ9hhQf79YbstsfmwI7DnVS8vx1Y7qDY44LHlPFYBjN3mo7scuwQI9CZroTD
	MdWLbi0uXBm8kMM5mzEnhRSdWoSLYKh1PD6ng4oEArkK9QeAXn3dT1EPtYeskyBsYZLu5Q/g0ll
	raCV08hfZh0Zlq6ElXNexhUO7v+lAACoFnBpDtuzQ3YIWz
X-Received: by 2002:a17:90b:4a48:b0:35d:9fe9:f830 with SMTP id 98e67ed59e1d1-35dd684eacamr1324687a91.12.1775122003834;
        Thu, 02 Apr 2026 02:26:43 -0700 (PDT)
Received: from yafangs-Air ([2409:891f:1aa0:8613:19f3:7bee:2e41:149e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35f50e9sm2227645a91.6.2026.04.02.02.26.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 02:26:43 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	song@kernel.org,
	jolsa@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev
Cc: live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH 3/4] livepatch: Add "replaceable" attribute to klp_patch
Date: Thu,  2 Apr 2026 17:26:06 +0800
Message-ID: <20260402092607.96430-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402092607.96430-1-laoar.shao@gmail.com>
References: <20260402092607.96430-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new replaceable attribute to allow the coexistence of both
atomic-replace and non-atomic-replace livepatches. If replaceable is set to
0, the livepatch will not be replaced by a subsequent atomic-replace
operation.

This is a preparatory patch for following changes.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/livepatch.h |  2 ++
 kernel/livepatch/core.c   | 44 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index ba9e3988c07c..d88a6966e5f2 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -124,6 +124,7 @@ struct klp_state {
  * @objs:	object entries for kernel objects to be patched
  * @states:	system states that can get modified
  * @replace:	replace all actively used patches
+ * @replaceable:	whether this patch can be replaced or not
  * @list:	list node for global list of actively used patches
  * @kobj:	kobject for sysfs resources
  * @obj_list:	dynamic list of the object entries
@@ -138,6 +139,7 @@ struct klp_patch {
 	struct klp_object *objs;
 	struct klp_state *states;
 	bool replace;
+	bool replaceable;
 
 	/* internal */
 	struct list_head list;
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 28d15ba58a26..04f9e84f114f 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -351,6 +351,7 @@ int klp_apply_section_relocs(struct module *pmod, Elf_Shdr *sechdrs,
  * /sys/kernel/livepatch/<patch>/transition
  * /sys/kernel/livepatch/<patch>/force
  * /sys/kernel/livepatch/<patch>/replace
+ * /sys/kernel/livepatch/<patch>/replaceable
  * /sys/kernel/livepatch/<patch>/stack_order
  * /sys/kernel/livepatch/<patch>/<object>
  * /sys/kernel/livepatch/<patch>/<object>/patched
@@ -478,17 +479,60 @@ static ssize_t stack_order_show(struct kobject *kobj,
 	return sysfs_emit(buf, "%d\n", stack_order);
 }
 
+static ssize_t replaceable_store(struct kobject *kobj, struct kobj_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct klp_patch *patch;
+	bool replaceable;
+	int ret;
+
+	ret = kstrtobool(buf, &replaceable);
+	if (ret)
+		return ret;
+
+	patch = container_of(kobj, struct klp_patch, kobj);
+
+	mutex_lock(&klp_mutex);
+
+	if (patch->replaceable == replaceable)
+		goto out;
+
+	if (patch == klp_transition_patch) {
+		ret = -EAGAIN;
+		goto out;
+	}
+
+	patch->replaceable = replaceable;
+
+out:
+	mutex_unlock(&klp_mutex);
+
+	if (ret)
+		return ret;
+	return count;
+}
+static ssize_t replaceable_show(struct kobject *kobj,
+			       struct kobj_attribute *attr, char *buf)
+{
+	struct klp_patch *patch;
+
+	patch = container_of(kobj, struct klp_patch, kobj);
+	return sysfs_emit(buf, "%d\n", patch->replaceable);
+}
+
 static struct kobj_attribute enabled_kobj_attr = __ATTR_RW(enabled);
 static struct kobj_attribute transition_kobj_attr = __ATTR_RO(transition);
 static struct kobj_attribute force_kobj_attr = __ATTR_WO(force);
 static struct kobj_attribute replace_kobj_attr = __ATTR_RO(replace);
 static struct kobj_attribute stack_order_kobj_attr = __ATTR_RO(stack_order);
+static struct kobj_attribute replaceable_kobj_attr = __ATTR_RW(replaceable);
 static struct attribute *klp_patch_attrs[] = {
 	&enabled_kobj_attr.attr,
 	&transition_kobj_attr.attr,
 	&force_kobj_attr.attr,
 	&replace_kobj_attr.attr,
 	&stack_order_kobj_attr.attr,
+	&replaceable_kobj_attr.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(klp_patch);
-- 
2.47.3

