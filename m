Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5249827147B;
	Tue,  8 Jul 2025 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751975684; cv=none; b=puataQXj3R662DTr64xIAmytqDlYNYZ57RBz2WVRRK7hUdvn/Z0blWgs85vh6oQJLudccvMZ0wr96n9rIYIqlWMg5ci5w/pv79FpDgeh0FImkQO2Gr2d7eFxRavoaPl5Qw8LhHpWkPJRYvUgw/OEL+4A3M/9vGsiS2y6xObOSak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751975684; c=relaxed/simple;
	bh=6kDPYQjd8AtPRzEp8sTWR+daYx1oyoORPe3Bk7shSGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZAxPC+MGCAiUcbRNwdAjzkuQhlrFVQJaXSMxDpDz+jOlOJbDC1uqTx7GLuWpbAulDJM54eP4gxt+ARSgxUfIqMCRHIg3ENIJXYrqkyyDIoIYfafwmCK21G8dy/SDCj4auNLYa8n3xuxUfdKZC71aHlwU5qWeO0tDfykITIixoy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iT2iUml+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iT2iUml+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F54C4CEED;
	Tue,  8 Jul 2025 11:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751975683;
	bh=6kDPYQjd8AtPRzEp8sTWR+daYx1oyoORPe3Bk7shSGU=;
	h=From:To:Cc:Subject:Date:From;
	b=iT2iUml+PnAUAylP8sk5mxXdymZJPsiPzAdn+FVpobPLt80UtehXXeCh1QIGn5P+f
	 ef5GXBtyrr2KgFBwiDgBUv8m3X2XMw3wnABEpWDLrl+i6p7SLv5EeYRXf3ZElqB+Qe
	 Z8vlh6+2bbix183O93h3Hn20Vv5bKbCYFcSH7DHrR21UOUjgXDr7fQ/QN/1ZaExIz6
	 omLzQW64x8AfzLcyUw0pLeIsSgZC6yKnKNwSTIAS+fhLOF4962vvoKTyVywoQ/LLXi
	 7tYSzYm/j9fVOIaP4b2tDScodqrA07Vak2VCuLzZNTJR82nZQDjDGjvT+KuWkrxaiU
	 22F6plNANXnMw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/2] tracing: Fix an event field filter issue
Date: Tue,  8 Jul 2025 20:54:40 +0900
Message-ID:  <175197567999.977073.8989204607899013923.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here is a series to fix some issues in the tracing event filter.
The first patch removes the __attribute__ from the event format type
string, which can cause issues with parsing (detecting the string
type). The second patch optimizes memory allocation in
__trace_define_field() by only allocating field->type when it
needs to be sanitized.

Thank you,


---

Masami Hiramatsu (Google) (2):
      tracing: Remove "__attribute__()" from the type field of event format
      tracing: Allocate field->type only if it needs to be sanitized


 kernel/trace/trace.h        |    1 +
 kernel/trace/trace_events.c |   60 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 58 insertions(+), 3 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
