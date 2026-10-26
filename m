Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793056285;
	b=F2yG/DjeT/kI6gzs5AxMZ6pbBwUSks0J/8JQ4RMODqB/sO7bBSpG1o4HIutf9ezi253+
	 jDfZZ+UFTL9wcu+0qDexuiJv8f+8XSexiKC3fJTEv8oPjKTA2csWcigzEEffWhCtWMyf5
	 MGEEIuCutMdSUcw/dTtsFZNFOLhm1IJ4qEQuGA7mKp74aq8n8ZbsIY1A6eDmY0r0PKQkv
	 zGX0c/hBtCTej5/DYTQvr+mnmGLgla4dYY9dzan9Q040LD+ECzwSyAHt2vXgvXEG1Nrro
	 df9E2zkyqArlRi2mH3imHByAysNb7SHKNASWVSrFo2jHJQx3snmH6G21PCjEVlQiQ4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793056285;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Sq8U6qRkxAVCxLJVMdW3PdUBR2QnCqOWhnBaz9IJe/k=;
	b=kVDFXlEKxjK2kTNGdKWbrBqqdV4qhilqMqiK8T+39OrYAyJ+ZDQBDUMH5VsM8syhMR/H
	 Yku/0yhByWs+O06OVHUpcUhipt+mGO618gI7HN7iZiczYkC3dlTkG0La+znf43jb3zeh3
	 Umz5kSTgi1EmsnMsgbyj5/uIlPU97JawTWOuqKp4G/oZDiPqZN2kXe/cEXJf+DWNVr728
	 V3eHp1FcH+Vz43l40SYLTgWmDFZ/3gSZ8fV/FwopaIdE2zI/ggAtfZ2GprjR7m7SB/cQf
	 1+NvhsiyVtOmDJgNQ9Wm/l84+Lb++qBcGNDjmANR4HAvER5bxWukTpMY/dGuiaMkrLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jhCj6au1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7914B606A31A;
	Mon, 26 Oct 2026 23:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jhCj6au1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D223F1F01825;
	Mon, 26 Oct 2026 23:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793056285;
	bh=Sq8U6qRkxAVCxLJVMdW3PdUBR2QnCqOWhnBaz9IJe/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jhCj6au1k5AOhOtgclDmE+QL9AVzh5MUBFxg00YqaxsnCigg+6Kn9VbFM7CG08sHs
	 Gny7d7kNGKTfG/VZCLtihttNO48vi1iNnTWXrE9HFY9ww1zwAXbYGe9V1Gfs0NvZiG
	 sejWtQqWvIn8YadQqIHsqE43iS5VBbw4/rm691IxxmQLxvkakhWat/jSG624n1ZjmV
	 6zbC+BsZB6oQ+jhQE9yKqUrp6xJ+8Vwf0vdZFoa7l1dRu+d4UHf38BiQpWL6tf/Dbp
	 Mk2U1n8yQM0/6xhRwUiStuZt3bqAy2yBqiERoCNTTmC+cJryvPvjo3DHU9sQ9GMv50
	 8l8JUan1ZDktA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/9] tracing/filters: Fix MATCH_END_ONLY regex matching for fixed-size strings
Date: Tue, 27 Oct 2026 08:11:22 +0900
Message-ID: <undine-1793056282077825155-5234c76709b60359@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <179291743946.492959.9624495647021680807.stgit@devnote2>
References: <179291742944.492959.11659339795290028998.stgit@devnote2> <179291743946.492959.9624495647021680807.stgit@devnote2>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Sun, 25 Oct 2026 17:37:19 +0900, Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> regex_match_end() calculated string length as "len - 1", assuming @len is
> the string length including trailing '\0'. However, for fixed-size string
> fields, filter_pred_string() passes field->size as @len, and for "comm",
> filter_pred_comm() passes TASK_COMM_LEN as @len.
> 
> Because @len in these cases represents the buffer capacity rather than the
> actual length of the string, regex_match_end() tests against the tail of
> the buffer (typically trailing '\0' padding) rather than the end of the
> string. Furthermore, if @len is 0 (denoting an empty dynamic array without
> trailing '\0'), "len - 1" underflows to -1.
> 
> First check "len < r->len" and return 0, which safely rejects negative
> lengths and cases where the buffer capacity is smaller than the pattern.
> Then compute the actual string length using strnlen(str, len), which
> bounds the scan by @len (stopping at the first '\0') without dereferencing
> past the buffer.
> 
> Fixes: a3291c14ecf0 ("tracing/filters: Fix MATCH_END_ONLY filter matching")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
> Changes in v2:
>  - Check "len < r->len" to guard against negative lengths and avoid
>    calling strnlen() when the buffer capacity is smaller than the pattern.
>  - Use strnlen(str, len) directly instead of calling strlen(str) when
>    len is 0, avoiding an out-of-bounds read on 0-length dynamic arrays.
> ---
>  kernel/trace/trace_events_filter.c |   10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index 5e74d2dae40a..fac51a2953dd 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -1075,10 +1075,14 @@ static int regex_match_middle(char *str, struct regex *r, int len)
>  
>  static int regex_match_end(char *str, struct regex *r, int len)
>  {
> -	int strlen = len - 1;
> +	int slen;
>  
> -	if (strlen >= r->len &&
> -	    memcmp(str + strlen - r->len, r->pattern, r->len) == 0)
> +	if (len < r->len)
> +		return 0;
> +
> +	slen = strnlen(str, len);

Hmm, this fixes 2 different issues. One is out-of-bound access issue (len == 0 case)
and MATCH_END_ONLY for COMM/STATIC_STRING issue. For example, FILTER_COMM will pass
the TASK_COMM_LEN as @len, thus "str + (len - 1)" points the end of comm array.
Thus in most cases, the filter checks only the zero padding area.

OK, let me split this into 2 patches.

Thanks,

> +	if (slen >= r->len &&
> +	    memcmp(str + slen - r->len, r->pattern, r->len) == 0)
>  		return 1;
>  	return 0;
>  }
> 
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
