Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793237960;
	b=S2zeKR0ZzC31UQYWdHspKs37aNZEB4BaSq9ZY5Ii4FMYrNpcpE8H9ti7gnWnjX0AjESO
	 o9rC5hFwFmygzJxkyLzo0ctLqfsPyk8Xm3Vt4gx1ehMGkvpSz16HCplSrlE9WY55vPNcK
	 +BvsDNdkyF0DrIQN8yVhEQ1gww3Psqtk4muLZ9h/odxmGQeInBoU/QkyfFSu/qYCvpvXl
	 nRt4k3HwulKtiW0hElLQ67SHtGnzwM1P9U37eRqRJ6x9DFIRat67jhr0AGsNYdqgDXBGm
	 YBksehaKDTVq3hG53fm1xxD4PchMzekGJZIr7DNXZIEbupDfSTKhaDG/D2XT74WC22w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793237960;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=s99K6eWhcW5sgoLWTd5wVX3zjRGcVmpyGmpRZ78IheI=;
	b=5KerM+3DxP/+nBWejR4bxazTOj3kVzDX8nlRzEqhZ90qxta4ilq5+WF1N5zhEfrHQ0s/
	 e9rrfgrrFUewET7SkN8fgp9EELBU7MDelwBxYwYxYNtKpjIfuKxwnsbRr5INlrPtdZFT4
	 GE/eYEYWtyjdT+6j/ch/uDICJecjU6Bix2F/sG6UnVj7WDpBqkRBNuftqMfh7HW5Y3cpJ
	 POmI7DEKP6NBDquyQcNRvn/vPsMROAGK19oEKbz3umANZAq5v7wUc0ggAngeBFns7VVOk
	 PQX72BcyJmmWdxage4Dl8Y8otwzQ59JAt4JpMzGuQbAXfUCB+HoSL6wC/+GYM1g9Cdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kid/ci80";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CEE606A31A;
	Thu, 29 Oct 2026 01:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kid/ci80
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25A61F01825;
	Thu, 29 Oct 2026 01:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793237960;
	bh=s99K6eWhcW5sgoLWTd5wVX3zjRGcVmpyGmpRZ78IheI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kid/ci80f6sFSRIdRzVhfzpal0oCctbrcptKq3m9rcI6kn2KPFup1HXECyZpQt2Ru
	 5FlzFpaa+P2FXZ6pyzRs1lWhwkBZlR38S3WdeH9Yoxl5l6fInyDcLI5ioXJqyjX/66
	 KF56DsVB0Wh/K0tDC7T23FKBrwBzZmAXz2gywmEQYeSJRyU0w5Fnbh3e2354Rfq2jx
	 jEZ22Oh0g1JQJ1rO0WSNMvriXnjcTUP+FyGGiI3P668z3ubjBeD1fSXO767aX+2/kc
	 +mThQue2+BKrdxj/Tgw+owwVEPAbZqFpwqiMcYEMe/q/u97mYS+Yj8w22hgUpaXnBC
	 5N8QYKM6c946w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 12/15] tracing/filters: Fix error position for function filter operations
Date: Thu, 29 Oct 2026 10:39:16 +0900
Message-ID: <179323795644.740114.16497027792194996862.stgit@devnote2>
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

In parse_pred(), by the time the '.function' field size and operator
checks are reached, 'i' has already been advanced past the operator to
the operand.

Save the position of the '.function' modifier in 'fn_pos' and pass
'pos + fn_pos' for ILLEGAL_FIELD_OP and 'pos + op_pos' for INVALID_OP
so the error caret points to '.function' and the operator respectively.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v4:
 - Drop Fixes and Cc: stable tags since this error position fix is a
   cleanup.
Changes in v3:
 - Newly added to fix error positions for .function modifier and
   operator checks in parse_pred().
---
 kernel/trace/trace_events_filter.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 6ff208f0e033..9b1100769676 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1701,6 +1701,7 @@ static int parse_pred(const char *str, void *data,
 	int op;
 	int s;
 	int field_pos = 0;
+	int fn_pos = 0;
 	int op_pos = 0;
 	int i = 0;
 
@@ -1742,6 +1743,7 @@ static int parse_pred(const char *str, void *data,
 	/* See if the field is a kernel function name */
 	if ((len = str_has_prefix(str + i, ".function"))) {
 		function = true;
+		fn_pos = i;
 		i += len;
 	}
 
@@ -1785,7 +1787,7 @@ static int parse_pred(const char *str, void *data,
 	if (function) {
 		/* The field must be the same size as long */
 		if (field->size != sizeof(long)) {
-			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
+			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + fn_pos);
 			goto err_free;
 		}
 
@@ -1795,7 +1797,7 @@ static int parse_pred(const char *str, void *data,
 		case OP_EQ:
 			break;
 		default:
-			parse_error(pe, FILT_ERR_INVALID_OP, pos + i);
+			parse_error(pe, FILT_ERR_INVALID_OP, pos + op_pos);
 			goto err_free;
 		}
 

