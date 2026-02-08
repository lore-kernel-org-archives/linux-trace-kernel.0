Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A221D5178;
	Sun,  8 Feb 2026 00:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770509837; cv=none; b=VtY4aUDJQZchFEFwgNQ0PGbyZpIOUkbJhtDZ6WBl5zdVNch5IrUoTiAjCgh5mcP5eWikeXw5dE+yqfWnWKaRBolGYka5/jo+HFYT6jbB7hXsa/r/vW20GT9NcR47oDX7V4/WsWEBrzCZltgBuDTzqeA4O5rkYCXKB1ggqXHYIUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770509837; c=relaxed/simple;
	bh=zTPy7digGEuR7rnpxYuQHD9Zji/5rZWEoD03yQ904jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eA3rrzl7XWN7U07mjBdhWcBx2vTyQyDnDYkcQ28QL1Nnb+E2aRsIXiGnv7thV30+M9QPVV6btNhUPFKMVB8XcvOHtphnyeUIKrx3zlhou/0vcvzC+SE4EB/OZFJK0kSHmZMS0hZlYkf+xUau0Bd8AdXwThEa3M5/c+K0YJ1sApk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id A66BC1B2EFE;
	Sun,  8 Feb 2026 00:11:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 10DF220025;
	Sun,  8 Feb 2026 00:11:51 +0000 (UTC)
Date: Sat, 7 Feb 2026 19:11:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v3] tracing: Clean up use of trace_create_maxlat_file()
Message-ID: <20260207191150.1fcc2666@robin>
In-Reply-To: <20260207191101.0e014abd@robin>
References: <20260207191101.0e014abd@robin>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 5nc8aeqmz4bqp9847mpbsm1yxutsu3ms
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 10DF220025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+AfWeDQLN+HQ8hG2htmb3+3fhTI3UtOmY=
X-HE-Tag: 1770509511-266864
X-HE-Meta: U2FsdGVkX18SmklEBct2A5KIVkHChsLIH+QAcxcLwKvOYsUT337Zvlig2k8JWpx/rL6HMbYeiBARxkLNV3/m3A/9yeLlBDbVhV1/ai8QWnlLzaXZc7rJ35kjmhlhUnaHs+UQj/Ol+sboCi8oe4CJHQ6U0+QmaQNrtoquZqfVsxTs6lo7EO9fx51MFOLKfZTeS8DcVbWAtqw2T2QHHZbvtQMSTQVUzFtY0zkYGIybMKQgzY9MDESH1/c418L9jQRp5/JwzUJ08+JcDeM6Sx5rDdhxblAgl+b45+Tv2UIELxz/uWzyKKaFREI/ZhBqPwxV


Was supposed to be "v3" in the subject.

-- Steve
