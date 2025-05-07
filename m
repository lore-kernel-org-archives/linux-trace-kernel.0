Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549A8224FD;
	Wed,  7 May 2025 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746653348; cv=none; b=IPiiIoefV4s0uTFz4DYcmvevMp17xZpn2Vycf2lUVmqb2MqO9wIQXkay31KJxFvoUnfLPwFHQeGUM4nI9BPBIE5d/y9RSsBRLJu3O97J0XRVP7O4o+mSzvH8IQGQwsTmk9czfRmo4GSmtdxOCSlKwyTTA/YTuoq6PqPlNMCj8As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746653348; c=relaxed/simple;
	bh=VQWR7y/7SXufNiXIXhHJb6v/20nvpOwD982fKy+C38U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ojKnlPf18QyW+igM49FVGzNgl4tOSlqySONe+A5joIzXW587OniS31+kl8e5lYFodUWyjCJ3myJ5kpYI+2wMODB7WnBnLKnUZzYXX/Kw54lPnfFXIH5FmbmTPQs5Ds6HdVf9DYi4B8eHzkgjftCBbeAJajmuS38BrIeGqNNpSaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0654AC4CEE2;
	Wed,  7 May 2025 21:29:06 +0000 (UTC)
Date: Wed, 7 May 2025 17:29:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Paul Cacheux via B4 Relay <devnull+paulcacheux.gmail.com@kernel.org>
Cc: paulcacheux@gmail.com, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Namhyung Kim
 <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] tracing: protect trace_probe_log with mutex
Message-ID: <20250507172917.0b4e3043@gandalf.local.home>
In-Reply-To: <20250504-fix-trace-probe-log-race-v3-2-9e99fec7eddc@gmail.com>
References: <20250504-fix-trace-probe-log-race-v3-0-9e99fec7eddc@gmail.com>
	<20250504-fix-trace-probe-log-race-v3-2-9e99fec7eddc@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 04 May 2025 20:27:53 +0200
Paul Cacheux via B4 Relay <devnull+paulcacheux.gmail.com@kernel.org> wrote:

> From: Paul Cacheux <paulcacheux@gmail.com>
> 
> The shared trace_probe_log variable can be accessed and modified
> by multiple processes using tracefs at the same time, this new
> mutex will guarantee it's always in a coherent state.
> 
> There is no guarantee that multiple errors happening at the same
> time will each have the correct error message, but at least this
> won't crash.
> 
> Fixes: ab105a4fb894 ("tracing: Use tracing error_log with probe events")
> Signed-off-by: Paul Cacheux <paulcacheux@gmail.com>
> ---
>  kernel/trace/trace_probe.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
