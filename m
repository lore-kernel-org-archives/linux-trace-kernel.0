Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148329;
	b=ctA9zyXCfPZNvcBVnRa83gyZSEKB9dbj2d+7Yfea0QymXIUqPDgwcV2GF3sgn4i/ILve
	 yo9i6s2Qlx0gDlkdo0StqLGDBwDkodHOQoYvkmOE4aWAaNeoeAqUZXwXzqYiRYKVXZsVO
	 H9uiiF7HlhMzEOgvh3WGAEg3vuYYxfztjkfkxPq5m7q63N6TyFuNItb9ytclW0tRIuLWC
	 uEUG10NusFitdSAUx3c8bUz6nJQsYsLaaqMWPoqGORNw5uLfJ46Ub81SN65v1K3ILX7Zj
	 ypL9FN2EoU382IaHQcfuZIP7wepfw1g7cZo7vuIYvjqQnwUR9tRkVnJYqBexx9ZNVUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148329;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=32pyEStKpPAJayiwvXGFAJO4Ey9ffJNtPO2qnvPIGDI=;
	b=cC/bmXKYIXuIDuLXmhPyjjY5GELOFScfbYAjR4YtbgZti3oJnHxc+aI/RWVTcQIxUvmL
	 G5p0zdzpqvhOQvftknZyxopzgoBPojex1rmN7HaU7VNfZki7yI7JLXsoAEp1vg9PYmsD0
	 GTqaDRu3VSiUbzNQQ8sYE1K34MizEoLLJSngFhu19PvZY+VKooEvMByWrFRhyjGIHF93M
	 PjSmqYYJUjEGuE+7iuagt5tLmVjR9GY+PQhtZI6oSAV/mhhtSDuKituG75a4LmqK69zbH
	 EqlqhASzqrjMU2ZKQo72aXKaAfnAWCjWUqALuct5gi64BqePy8KRhmU+Oy+Qabx+LYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DVEVq7TO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687F1606A31A;
	Wed, 28 Oct 2026 00:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DVEVq7TO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7F91F01825;
	Wed, 28 Oct 2026 00:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793148329;
	bh=32pyEStKpPAJayiwvXGFAJO4Ey9ffJNtPO2qnvPIGDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DVEVq7TOfMyatsmScygNkKRRPQVsniOx51+VANpItUcXc47jYnFWSu30mR0dQuSxp
	 UHeyZ91wNeSfkHyWYbJlby3uwErxXFmhvJ140ig0iE1hGlzm/MjkT1CAWKchWnOwGL
	 X33v+hJzcpcH1uTH4gQ6JKQjYxN2xmqxuihayxKbiIe4RzsKdNsrtUhdgtCo2IZgY3
	 hSZy338c3P+nCyZJaZcUzKHPjQ7U98xlsPP0AhkeFxt4ewsttk03QqRN3KvAKFWpuU
	 XEBQFMP5izgkACzmUWb72pl7Fl8vArYS9YaCFkxZTg12v8/PuvVsGS8kTJruac6Bmi
	 OvMAFkZ4dTkvg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 13/16] tracing/filters: Fix error position for function filter operations
Date: Wed, 28 Oct 2026 09:45:25 +0900
Message-ID: <179314832538.684037.8818655317501581217.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179314820431.684037.4147763044424284198.stgit@devnote2>
References: <179314820431.684037.4147763044424284198.stgit@devnote2>
User-Agent: StGit/0.19
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

In parse_pred(), by the time the '.function' field size and operator
checks are reached, 'i' has already been advanced past the operator to
the operand.

Save the position of the '.function' modifier in 'fn_pos' and pass
'pos + fn_pos' for ILLEGAL_FIELD_OP and 'pos + op_pos' for INVALID_OP
so the error caret points to '.function' and the operator respectively.

Fixes: e6745a4da964 ("tracing: Add a way to filter function addresses to function names")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v3:
 - Newly added to fix error positions for .function modifier and
   operator checks in parse_pred().
---
 kernel/trace/trace_events_filter.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 903caf62a407..b1b4f1a57dc9 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1695,6 +1695,7 @@ static int parse_pred(const char *str, void *data,
 	int op;
 	int s;
 	int field_pos = 0;
+	int fn_pos = 0;
 	int op_pos = 0;
 	int i = 0;
 
@@ -1736,6 +1737,7 @@ static int parse_pred(const char *str, void *data,
 	/* See if the field is a kernel function name */
 	if ((len = str_has_prefix(str + i, ".function"))) {
 		function = true;
+		fn_pos = i;
 		i += len;
 	}
 
@@ -1779,7 +1781,7 @@ static int parse_pred(const char *str, void *data,
 	if (function) {
 		/* The field must be the same size as long */
 		if (field->size != sizeof(long)) {
-			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
+			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + fn_pos);
 			goto err_free;
 		}
 
@@ -1789,7 +1791,7 @@ static int parse_pred(const char *str, void *data,
 		case OP_EQ:
 			break;
 		default:
-			parse_error(pe, FILT_ERR_INVALID_OP, pos + i);
+			parse_error(pe, FILT_ERR_INVALID_OP, pos + op_pos);
 			goto err_free;
 		}
 

