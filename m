Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73529418368;
	Tue, 13 Oct 2026 22:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791929275; cv=none; b=e8Xs0KoD6fEJtqXrY0ZZtwCXnsyt2uZgPahZFeo+nOP7BXMtNy2ok3ctkGJA7NjLW257aZm3cw4TnTC1zvA5aeUO0DBxzRpPqWHMLTBgDi3cPdJjiBgX1mzfR182ElqgHw2JQa30FWXZXHESTqI0M+fJd6kZVXaTONrGISWAnmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791929275; c=relaxed/simple;
	bh=K13EsS3V3IKUrcVCNXSR+GbsX8hlyAFR61qogJGNsV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-Id; b=ZQY6g1nVVD3ByscUCZ+crQZIOKb5aCvkc7M6GO6Y+Wp8n7c2vAgXWDit9OcokguJzURXqJeUPIl+SOUhAAxlxmhW/hUuAPkVH5DkfQpO6+3dkGXXyczxK7AZFFqhRxyAWVsGu+jbcMzlomNpSdfFToC8nofLUTlXuRdNUp8IWlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+hZuWtG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+hZuWtG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E451F000FF;
	Tue, 13 Oct 2026 22:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791929274;
	bh=aupOmf6+kGIl5cSKM1BrCjyrRPm9/i1we5NAEbXEh2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f+hZuWtGZlTKb/ZfoGaHcxDagcJyV2FmMlqLDE6qDnhmqNS000m96mt4L5VOBq7fy
	 v4MJ934nTLgi1uY6nTaA9NjmymexDlHMxh6+vdssmLn6yoq3cqXsY/xRs4sakUQaMu
	 CcBtRcyPGnI0Lerxt/cubV0r5OX+H7XO8ylYdBpQtuzE0Bir9vG/2SriKgJBNMuVa5
	 IFlroWv9lVmctPooNJEUqEweytUnyI0SJzfdiQfLlPGNLnIVXVyS0vALUwlFYsfKjz
	 T8ZwTv7TAb4ktVg56mo++mMdVuGJVDkZDhnxdKMr0zH1f7SR/mzKoWl41dw2Ejqq6K
	 vThIpDADbDTzA==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: lee@kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/histograms: Reject non-stacktrace fields for
 synthetic stacktrace fields
Date: Wed, 14 Oct 2026 07:07:50 +0900
X-Mailer: UndineD 0.1
In-Reply-To: <20261013112449.1006088-1-lee@kernel.org>
References: <20261013112449.1006088-1-lee@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20261013220752.F1E451F000FF@smtp.kernel.org>

On Tue, 13 Oct 2026 11:24:48 +0000, Lee Jones <lee@kernel.org> wrote:
> In check_synth_field(), when a synthetic event field is a stacktrace
> (field->is_stack) and the histogram field is not a "long[" stacktrace
> array, validation falls through to the generic size and signedness
> comparison.
>
> Because parse_synth_field() sets a stacktrace field's type to
> "__data_loc unsigned long[]", its size is sizeof(u64) and
> synth_field_signed() marks it as signed.  Consequently, any 8-byte
> signed scalar histogram field passes the fallback check, and its scalar
> value is subsequently dereferenced as a kernel stacktrace pointer in
> get_field_size() and trace_stack().
>
> Furthermore, checking strstr(hist_field->type, "long[") is insufficient
> because tracepoint fields defined with __bitmask() or __rel_bitmask()
> also have type "__data_loc unsigned long[]" or "__rel_loc unsigned
> long[]", whilst create_hist_field() treats them as 4-byte scalar values
> without HIST_FIELD_FL_STACKTRACE.
>
> Propagate HIST_FIELD_FL_STACKTRACE to variable references and field
> variables (whilst excluding variable aliases from per-element
> stacktrace capture), and reject any mismatch between
> HIST_FIELD_FL_STACKTRACE and field->is_stack in check_synth_field().
>
> Fixes: 00cf3d672a9d ("tracing: Allow synthetic events to pass around stacktraces")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Good catch! Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
