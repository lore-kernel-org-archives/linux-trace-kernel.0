Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EA8299A8F
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Feb 2026 08:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770367247; cv=none; b=KMQD4Fe7mzdb/MQ+ymDXFmGGIOymyIVAa4nM1VIcgDf5+1o9nJS9SgsU4gtmxJzWu7kiDbsaS6kD1kXnoUhBFat8j5ORc8ksXzBuHupJHGfW9+IBAXH/dl6WgcJLi21oBVamrPO5wwtVgXJMHGwbBfHIbwcpZEZwbvuOma/f1l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770367247; c=relaxed/simple;
	bh=cv+6fIk3D4nHEPABl9PX+Ws19I9ZcwEjL4vKtvhyWJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WU4mR9WZhmN0OWWWZpqc7wGym80jTfzyIoBdkShrcV5X5mqi17o33gT9Arpbom9GmHZ5muySG4/JLfVABxMbenoiDV6sP8CWuExlOD8iNQuNp6ljo0SbFcin49b0/GgKkqFlrq2Lz+wI0/rQDF0roFQlt680ZPz7j+09gDuYf7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjjSl6r6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjjSl6r6"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a9004e4239so9273615ad.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Feb 2026 00:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770367247; x=1770972047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XQboP24vdJLt5P7SM8mfN5cyQRPoHgRI3awZo501LdA=;
        b=DjjSl6r6YKtyGc8qJsQGH5jsbDTGKhtMLVoC3IBZ9F0sTqScmYLPi3obkdRfgI5gZy
         4jORpO+wMwiTE8yAIH+GSz5mwaYtDyngCz4u5yg70pN6WORq87Jh4s7ZrTx5aOaw0s9+
         Ttv4x50VG+IedmojeEOuodA+GVyS1OoQydyE1U1KJuggw1s81G8BzEofmX8DRniwWAqM
         SfKi1kcX+GjXY+EjniHSfpS3X4xCkO04DjyekPy7nCTwkRQzldl+j8/YkInpVZTjTJYL
         AqinrKPn6batkquJaYcUZyg8CQtxiKIc79/iM1LIxqKMZZSpsoUPc9UCH6zmjp3xJsat
         pXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770367247; x=1770972047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQboP24vdJLt5P7SM8mfN5cyQRPoHgRI3awZo501LdA=;
        b=iCFZpmqd9OlAtOVExskLyDzr2CRS3wi86ahWIPFdkWMto2b7DRa0WAdiFSRCgqEp5c
         ruLGi71AzSVGlBOSyVLhvs8i9O7fMLJRsHjw4IGVM0ceUJhiUziHfaMr0QpWSB8RPNO3
         kqQ1zR36KFeBY6JianqfXB5DWZinVwKoFMtZzCFX8i75h/pyo3mBmG5dezHR7EQjhctM
         L76yQyxGW/UUpk+bZe7w/FUvj+vZr067z5SMp1lfDiwDRVBev9Vq8PZe/ArjX24gQC09
         Y0HGZC0uP/jTTcDxsWAnQ8HW6T+GUsW5g1NQRrZUrEhpOaTVV8jraao0u6+VQtHFGyP2
         RSGA==
X-Forwarded-Encrypted: i=1; AJvYcCVT9XhcKz2AOm9PvqJ8kl8/jVO3dHD0V6EhJjWnPE0hnHRtqys99k2GAQUMebpcfgi5lPJ3ySWcHAlNndN7Ie3XYEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6wBgrg3sPE8U6sHKG+7UKO5bnR5eAIynYwDONJhOKUtyyH8qX
	pHOV60RGavvQtL4F97dcGrlQmhdcr9YC+i8tOLOdhSS4A/Vt9tOXAWdW
X-Gm-Gg: AZuq6aJkRx/G9NRBWLAHq4VyWL6NFHqZAXUKitsfe5DifhWGvRIs9mQnUm+eHdStdNp
	Gj/6/ehWId8xsNYoIBj660DSZg6KAU1+FXJfD2lQiEio2xE6wxScZq4/Sn/WvcjZ0cvrUf1C9Dr
	fWB7qbBOcJ2jKvKEX8Hlc41MtFte2Nh6ed4TkTHq/O6D2BbpfCukwJ35y9ixM3w+/KfQV6mEbl0
	WPMQji7w3OhztCT6a+NRLOFXBdWBGnm6mIVSpXaxrFU8fxMymRnJWGfc9tQ67UONDkrbNn5Tzbw
	EpdISTbZcZhAzNYlKAaO9NJ+1twWkXAPlL2oT/61QWHGYfA3InGyzp2lUKtd5tSLm59E4cj41FD
	rW8ZHG1wiPw97vIOZu+f+zWFcVWq0ZFZIfS0ZfaegcUPT4e14YOSVguzsXrZbzAB//6OzSwRI+x
	pLpuZBzLngMjbC668dv6OxzN3XKnE=
X-Received: by 2002:a17:903:3c30:b0:2a0:c58c:fdd2 with SMTP id d9443c01a7336-2a95169b829mr21837395ad.26.1770367246903;
        Fri, 06 Feb 2026 00:40:46 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c8578dsm17896555ad.32.2026.02.06.00.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 00:40:46 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>
Subject: [PATCH] libtraceevent: Pretty print function parameters of enum-type
Date: Fri,  6 Feb 2026 16:40:41 +0800
Message-Id: <20260206084041.2049369-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

The tep_btf_print_args() function currently prints values of
enum parameters in decimal format, which reduces readability.

Utilize the BTF information to resolve enum type parameters
and print their symbolic names where possible. This enhances
the trace log readability by displaying meaningful identifiers
instead of raw numbers.

Before:
mod_memcg_lruvec_state(lruvec=0xffff88800c18a540, idx=5, val=320)

After:
mod_memcg_lruvec_state(lruvec=0xffff88800c18a540, idx=5 [NR_SLAB_RECLAIMABLE_B], val=320)

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
---
 src/trace-btf.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/src/trace-btf.c b/src/trace-btf.c
index 859b0860ce2a..85f5fefb4d3b 100644
--- a/src/trace-btf.c
+++ b/src/trace-btf.c
@@ -32,6 +32,16 @@ struct tep_btf {
 #define REALLOC_SIZE (1 << 10)
 #define REALLOC_MASK (REALLOC_SIZE - 1)
 
+#define for_each_enum(i, enum_type, member)			\
+	for (i = 0, member = btf_enum(enum_type);		\
+	     i < BTF_INFO_VLEN(enum_type->info);		\
+	     i++, member++)
+
+static inline struct btf_enum *btf_enum(const struct btf_type *t)
+{
+	return (struct btf_enum *)(t + 1);
+}
+
 static const char *btf_name(struct tep_btf *btf, int off)
 {
 	if (off < btf->hdr->str_len)
@@ -546,10 +556,11 @@ int tep_btf_print_args(struct tep_handle *tep, struct trace_seq *s, void *args,
 	struct tep_btf *btf = tep->btf;
 	struct btf_type *type = tep_btf_find_func(btf, func);
 	struct btf_param *param;
+	struct btf_enum *enump;
 	unsigned long long arg;
 	unsigned int encode;
 	const char *param_name;
-	int a, p, x, nr;
+	int a, p, x, nr, i;
 
 	if (!func)
 		return -1;
@@ -628,6 +639,13 @@ int tep_btf_print_args(struct tep_handle *tep, struct trace_seq *s, void *args,
 			break;
 		case BTF_KIND_ENUM:
 			trace_seq_printf(s, "%lld", arg);
+			for_each_enum(i, t, enump) {
+				if (arg == enump->val) {
+					trace_seq_printf(s, " [%s]",
+						btf_name(btf, enump->name_off));
+					break;
+				}
+			}
 			break;
 		default:
 			/* This does not handle complex arguments */
-- 
2.34.1

