Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C770611E;
	Thu, 21 May 2026 04:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779338959; cv=none; b=BJfVDL4qqYQ+OlwpxuuKc4yFs645LPGr3Ssh1P2CQ/SKeTggbq2zI2lHOUarQCQYMV2aLarR65HCUnvdnFrZCMg0ceSl6aTjHVaxDgC84fE7U1FnW22rUEPWsD2SQUMNqPTMbEnj8dFljOyowQ18p+XtsCVUEzprBGJ08y9OLa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779338959; c=relaxed/simple;
	bh=hsU5EH9siijsEb0Sa5mFPv04KdfIuQvfME1A1w3RCdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7FK5yofQ9hmKqSGhiaZPt0Chk/40cnxQYftkXMmc3MdgobwqS9idF7E8FWDxDPv3FO3yHNP8ch1PAF3hKT2QMLgsBz0/NFZ8D7SbFKLicgmbAoZOLZGSu6re1y1EABRwFFRsu6IYKbO+1mMYfxcO5fTQ68gGowHk8BeKhftB74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmWKg1mo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmWKg1mo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2121F000E9;
	Thu, 21 May 2026 04:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779338958;
	bh=amFFg8ZKuDh0+/poWq7eajIdGgc/eR/hzn2uTpVP8+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mmWKg1mo/IrtGMFxtTmmbs7XbwczS36wc4KJMNLcuKyzS4hQuHGiUBPnV0sRqVpL7
	 zpNVsJqz1jZ5FEmHuOpXx8L8JKR/BYbhArzOS4FP940TKUxCzsBgC42MmrvcfebW+6
	 t0XIayO3W7a28XMULP2/jh9J7BcWfpAPCQyvZeqiqK6jAMyZ7I9aE0tge53ta5nHbw
	 kPBYVlK5b0etuyz77ETFwxC0NJijMZsHBY5wACr1opxqLuzPmhQwy5Pfz8aWS43TgG
	 3/YLb9UzRm2YvULxDInRParpPepaGswC9zt+9jfUCzpIVwp2JH+3V8ZCL+dIYG2DAc
	 hauTT6O1jnKuA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Rosen Penev <rosenp@gmail.com>
Subject: [PATCH] tracing: Do not call map->ops->elt_free() if elt_alloc() is not succeeded
Date: Thu, 21 May 2026 13:49:14 +0900
Message-ID: <177933895460.108746.5396070821443932634.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520223101.34710-1-rosenp@gmail.com>
References: <20260520223101.34710-1-rosenp@gmail.com>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

In paths where tracing_map_elt_alloc() failed to allocate objects,
the map->ops->elt_alloc() call was never successful. In this case,
map->ops->elt_free() should not be called.

This bug was found by Sashiko.
Link: https://sashiko.dev/#/patchset/20260520223101.34710-1-rosenp%40gmail.com

Fixes: 2734b629525a ("tracing: Add per-element variable support to tracing_map")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 kernel/trace/tracing_map.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index bf1a507695b6..0dd7927df22a 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -386,13 +386,11 @@ static void tracing_map_elt_init_fields(struct tracing_map_elt *elt)
 	}
 }
 
-static void tracing_map_elt_free(struct tracing_map_elt *elt)
+static void __tracing_map_elt_free(struct tracing_map_elt *elt)
 {
 	if (!elt)
 		return;
 
-	if (elt->map->ops && elt->map->ops->elt_free)
-		elt->map->ops->elt_free(elt);
 	kfree(elt->fields);
 	kfree(elt->vars);
 	kfree(elt->var_set);
@@ -400,6 +398,17 @@ static void tracing_map_elt_free(struct tracing_map_elt *elt)
 	kfree(elt);
 }
 
+static void tracing_map_elt_free(struct tracing_map_elt *elt)
+{
+	if (!elt)
+		return;
+
+	/* Only objects initialized with alloc_elt() should be passed to free_elt().*/
+	if (elt->map->ops && elt->map->ops->elt_free)
+		elt->map->ops->elt_free(elt);
+	__tracing_map_elt_free(elt);
+}
+
 static struct tracing_map_elt *tracing_map_elt_alloc(struct tracing_map *map)
 {
 	struct tracing_map_elt *elt;
@@ -444,7 +453,7 @@ static struct tracing_map_elt *tracing_map_elt_alloc(struct tracing_map *map)
 	}
 	return elt;
  free:
-	tracing_map_elt_free(elt);
+	__tracing_map_elt_free(elt);
 
 	return ERR_PTR(err);
 }

