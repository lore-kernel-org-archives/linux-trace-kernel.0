Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793237970;
	b=lG+595z3wuqCLaR4QBFSq92fl4WuJPcrh6ygErF6oQcWY6TNWICzXKBhdP93y+IHEq67
	 VNMiJcoTMf817Ti1Wh7j/Q6RxaWgRZFSNhpKyn3VJJc15iAfGpCbc/rCAMP9TJZSEZ5u9
	 jkrJL1mc2NMS42yQkhOGiMMK42qevtUrJqIUm5he0pWxIgDI4LM5P6vJGVFg3Ul6bJP3L
	 TZ5ITDhU8Rr8RwGe3h6SF8xsyFeYPlmlH5hYPXiwhr56LUwtsBY6j77+czNcY1xUSLos1
	 zrtK+hvNodnUVeX6/tAkJ/slJHR+VVKcICCWKhaspAZDa3aJGnSaFoZwiUFtY9961DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793237970;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6rCPF0CTrQ3k1mxd4WynCcmI/nixNYhjIdPTAW8jCQo=;
	b=goysNwciLocBLN7uzpYnJLKn2rOj4agIMxpwvVdVS1WLH8hJzkJ3Sv0ykcuDOCMlLIc4
	 DtIUxxq6IiviaAkulFMSH2Cgct2FFcQOQ1HrgNwpMQ7bWdtgklEMzwy7A/Ce1f7UFr174
	 RD3TPQN8rO4aoVi/hSm+Fm8K/xvYHDPQ4fwCnE8viX5jJWwT8m1f2A9Q/ZXth246hBB/D
	 QT3jUhH0PZIiK11XZ/dWK0qf6KsSARQJzVdupviQA699UK8zTnNh1fw7zMYqUlWP8vBrf
	 tDDzM/YDT9gGdpsZSWx2RkfO8jjBTFKMjBWj7dCpj6lvpdqhoqPkAZi+xDwm28IU/zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ct2cPCOS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B23606A31C;
	Thu, 29 Oct 2026 01:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ct2cPCOS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082751F01825;
	Thu, 29 Oct 2026 01:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793237969;
	bh=6rCPF0CTrQ3k1mxd4WynCcmI/nixNYhjIdPTAW8jCQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ct2cPCOSwpY1PSvQLej18EXFKbSDPbW75k/kfAfEZ0Ai1xB9jCEnj4x2Qws1lGM/T
	 iankJyIwg9LbBBAY978xmdNLwdcmxUSp837cmmWsKFmFpPwoVa4jvWsfluaJ8xYHr/
	 89rNjho9kCVzkecQK634JlCVGbiY1fDw2qxMNQyHs7aKWOOc39PE4q9eoDwZzpjsku
	 SXHY5mktKCmxgcArOTr5Y0T6QuvHxGB94nveau3IeAQX86JfLKYupG3Mo/Fhiju1X3
	 7F9EqzFlNJfz+d94KJyp0M4BUEXEme/AcFF2/rbpCAseV9OzuD6wqYnG7NJ4KeNzPb
	 9rxYOFDPxcY1A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 13/15] tracing/filters: Fix error positions for CPUS mask parsing
Date: Thu, 29 Oct 2026 10:39:25 +0900
Message-ID: <179323796570.740114.12151091552524337676.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179323784538.740114.15323117974242744566.stgit@devnote2>
References: <179323784538.740114.15323117974242744566.stgit@devnote2>
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

In parse_pred(), CPUS mask error paths report incorrect error positions:
- Checking 'str[i++] != '\'{'\'' post-increments 'i' before calling
  parse_error(), shifting the error caret one character past the
  missing brace position.
- In the CPUS operator check and comparison function selection check,
  'pos + i' points to the CPUS operand or past it instead of the
  unsupported operator.

Check 'str[i] != '\'{'\'' before incrementing 'i', and pass 'pos + op_pos'
for the operator checks so the error caret points accurately.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v4:
 - Drop Fixes and Cc: stable tags since these error position fixes are
   cleanups.
Changes in v3:
 - Group error position fixes for CPUS mask parsing into a single patch
   targeting commit 39f7c41c908b and commit 3cbec9d7b93d.
---
 kernel/trace/trace_events_filter.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 9b1100769676..1a9a1cc8daa2 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1932,16 +1932,17 @@ static int parse_pred(const char *str, void *data,
 		case OP_BAND:
 			break;
 		default:
-			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
+			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + op_pos);
 			goto err_free;
 		}
 
 		/* Skip CPUS */
 		i += 4;
-		if (str[i++] != '{') {
+		if (str[i] != '{') {
 			parse_error(pe, FILT_ERR_MISSING_BRACE_OPEN, pos + i);
 			goto err_free;
 		}
+		i++;
 		maskstart = i;
 
 		/* Walk the cpulist until closing } */
@@ -2029,7 +2030,7 @@ static int parse_pred(const char *str, void *data,
 			}
 		}
 		if (pred->fn_num == FILTER_PRED_FN_NOP) {
-			parse_error(pe, FILT_ERR_INVALID_OP, pos + i);
+			parse_error(pe, FILT_ERR_INVALID_OP, pos + op_pos);
 			goto err_free;
 		}
 

