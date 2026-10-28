Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148292;
	b=myejljBMtuf8B40zeMeUjlq1mliTt7kyIRhTBRILco43E7id5pHBU3uqR90cJg8+ZMSx
	 myEnfY3D8s3kfdxw0Lu3uQ0wL85A//wn8NlcOLG7LF3s7QfYMQaMI5gQY60Qjdn25sLVp
	 fo/BnOAwupQWcwpBzo5XeCVkacy0WIe/BNTCJMZg3MqzwIo8usINu+PdL24mZZUl8O3UD
	 wr/E146Wyettavbf1XolKln1oPno/ranYfJRSwQcQkWcYPAmJwXBQc0JHdEt0Xd4Z5LHc
	 Cnt7MVgYoUv5RbgM0IyWRy1/F2IE1UI7yG4fKrk75ICONBcU8NTb5OynVjo4GUVdqiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148292;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IgL8NI0+jVuPGw0j5V6hwopHTIPzPDvMLUwmZ3dLpdI=;
	b=Corz3YXIe0DAJvzJhkf0+gpnjT0fytw/jGdm7tlFDDiXAUrQCkn+zwWZpNfSrl/wmNEr
	 CqOH6zqUWZ1gAJK8lo5nxsnHsmV3+bOINOy+RofXqdPEW3hS/IsYyN4YVecFGQXv6GcFh
	 1nBIOLPZKhDHFplXLb6nHqwy7L0Ehfc6ahRYsV6jL6ab9op5I/H44sZspiYtcmLrpvJ1o
	 9VB4aUYXOJBgamW+YDNRWDlmt5qfaBvVbwlsVA2N3h92DW0Gk7w/4wkle1Pcd2tP5pYOe
	 gtQEvaiAEwW6Jfz2aEyR1TBGaUEPIV7xf7Ub2J7TOp/P/cviNY+HmzITlB5MSDzpiIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IM5sY49g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EA3606A31A;
	Wed, 28 Oct 2026 00:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IM5sY49g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902681F031E0;
	Wed, 28 Oct 2026 00:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793148292;
	bh=IgL8NI0+jVuPGw0j5V6hwopHTIPzPDvMLUwmZ3dLpdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IM5sY49gM6N/7ktqXHwu6Zd4jjA9KJi0kunGE9qFwyPBN/G5dmMPbNyeP5N6T4Wxs
	 BcM6regGtA17GVC88vyZE/Ny93iGa4HYTIAabMsY9pMGQ/3ngqyNKEwa+H5Pq47moJ
	 m8lPJke9g9ZBvGLyN8VmE1NfS76cZ0fZ/7seL0TX1XNTp0IpJd1oPCqpu41g3o26IP
	 0VDCr3rjb+rt2G4envTGT/AECHxyWGPzjSVDGoAZXL3mO4xCY6bYcsmyaswECY+70O
	 Ol6x9/cojzEsLfkXd7Kz2opdd6abARIEdUFjJPsepe39AC6nGWYSa1C+SHKmt+I87t
	 ti0rYxatsor1g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 09/16] tracing/filters: Reject stray quotes and parentheses in unquoted function event operand
Date: Wed, 28 Oct 2026 09:44:48 +0900
Message-ID: <179314828848.684037.8273600995293830928.stgit@devnote2>
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

In parse_pred(), when parsing an unquoted operand for function events,
the loop only stops at ')', '&', '|', or the NUL terminator.

However, calc_stack() parses '(', '\'', and '"' independently to
determine stack depth and string boundaries. If an unquoted function
operand contains stray quotes or an open parenthesis (e.g. "ip == foo'bar"
or "ip == foo(bar)"), parse_pred() consumes them as part of the function
name operand, causing parse_pred() and calc_stack() to desynchronize.

Reject unquoted function event operands containing '(', '\'', or '"'
by reporting FILT_ERR_INVALID_VALUE.

Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v3:
 - Split from the monolithic function event parsing patch into a
   standalone patch rejecting stray quotes and '(' in unquoted operands.
---
 kernel/trace/trace_events_filter.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 96977eb9af85..48e16d75be74 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1863,9 +1863,17 @@ static int parse_pred(const char *str, void *data,
 		for (; str[i]; i++) {
 			if (q && str[i] == q)
 				break;
-			if (!q && (str[i] == ')' || str[i] == '&' ||
-				   str[i] == '|'))
-				break;
+			if (!q) {
+				if (str[i] == ')' || str[i] == '&' ||
+				    str[i] == '|')
+					break;
+				if (str[i] == '(' || str[i] == '\'' ||
+				    str[i] == '"') {
+					parse_error(pe, FILT_ERR_INVALID_VALUE,
+						    pos + i);
+					goto err_free;
+				}
+			}
 		}
 		if (q && !str[i]) {
 			parse_error(pe, FILT_ERR_MISSING_QUOTE, pos + i);

