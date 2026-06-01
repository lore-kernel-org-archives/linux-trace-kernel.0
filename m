Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A2B188596;
	Mon,  1 Jun 2026 17:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335051; cv=none; b=PYut4nLzgG7OIdYErvs0NvAyc9dLxyAaQikrzRVfTAgR07SHtCBGcTEfMlIPXeZ6CP1RBJ14MG4Inp7kpvVsdKv38wCV4SzPEAHCeD5AgS8VObsNFt48WCI/oIkBz9s6ozlKlUn37B+speWRER0c5udfWHgPIlGDb7ZmV+eRsms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335051; c=relaxed/simple;
	bh=97+NW5U8onxsm044d2kfWmY/xSuGmDM03nGe1Q7YAaE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HD+aYoFVPOwMDyJBAA6yzxccYNwWh8hjodfogobnQJ3ZJALwNg4JxpnqyXEzkdafCr3sF10CuqulbNu58LFYzXE2S12W5CqXOULWkkSkkZbjRWJVc7QL7ovtSSE0s4d4b2nYn5uBPFDS4cPfRp6DTPxSy/cLD7kFg/pzMvbi6mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id D6217C1DA7;
	Mon,  1 Jun 2026 17:30:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id E95FD20010;
	Mon,  1 Jun 2026 17:30:43 +0000 (UTC)
Date: Mon, 1 Jun 2026 13:31:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers 
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>, Douglas Raillard 
 <douglas.raillard@arm.com>, Tom Zanussi <zanussi@kernel.org>, Andrew Morton
  <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ian 
 Rogers <irogers@google.com>, Jiri Olsa <olsajiri@gmail.com>
Subject: Re: [PATCH v8] tracing/eprobes: Allow use of BTF names to
 dereference pointers
Message-ID: <20260601133129.4a1e9dec@gandalf.local.home>
In-Reply-To: <20260601130746.2139d926@gandalf.local.home>
References: <20260601130746.2139d926@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: tqnkbqoi895my9wxtnfmknn3f3urin6m
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: E95FD20010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18HbeiqPwovAe31KOlwWtoTq4MfqJXC3+U=
X-HE-Tag: 1780335043-44465
X-HE-Meta: U2FsdGVkX18W7RATBPIKEdSvGxOeLk5OPustDhAYZnF7I7vvn2OT6hZyo8/AmmmOqaIYgJ9zlQLeFjkdBjLIlg0MbPXjTfQiVnXJORyh231t2QehhIMtv8BCBwyr3IB6vz2J+q6rQIBdiMpmhknQKq9bYHa8r02YibOdx9HOBDF510TD5zHDPy/9CcfuCKIEUNvsLcEXf0PyaLweHpcd5wiSMuJnpDvImes2OsvkxOtDOV1q+MeVrXJG24XV5guB9fi3pxKvb1R6GfIidmzE/chC+RUFm2FDMBzdGtunoqeNAMMRGeWaXE0F18kYap965xc9bO3MEi0f1iUfyRPKORXyu9tYqBA5WqyfN40WQGaH24yahB9eLO0AbiHuVwwAjLwg3ldqVfx2PmzFriRo5JEglgrLWEkqVCkSxLZ3LfpBhz40ZJJC/KKpwNyrZIHHMALMs+kNNWMFnKiOcnxCSQ==

On Mon, 1 Jun 2026 13:07:46 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Changes since v7: https://patch.msgid.link/20260529110442.0967a64c@fedora
> 
> - Add error message in parse_btf_args() for failed parsing of TEVENT.
>   (Sashiko)
> 
> - Remove TPARG_FL_TYPECAST and just use ctx->struct_btf instead.
>   The flag was redundant and added unnecessary complexity.
> 
> - Restructure to keep the lifetime of the TYPECAST to the end of
>   traceprobe_parse_probe_arg_body(). This allows the last_type to stay
>   around in case there's not a type parameter and then btf can still be
>   used.
>   (Sashiko and Masami Hiramatsu)

And I rebased onto probes/for-next

-- Steve
