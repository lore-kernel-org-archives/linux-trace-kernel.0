Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E76D267714;
	Tue,  3 Feb 2026 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770134198; cv=none; b=SEyglkEs0ri0VlPr+gXhbHuH/ArYI7tqzCiB6/sQZ7XrROdNRIZ1QV00yM5lMryksNCoGwQhSd1/c5akFkfqRn1yt9DROpOMcjato0xQJbrqTEwkWUyA8bxjVfQLdwS6dvSq4LnMcsGO0+SfYu9FOJ/FXnzBljbEuW+Z3kh8MI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770134198; c=relaxed/simple;
	bh=5VQb6XurkFIcrW15lovmU7utC3GXjrZZ5DPn4PqCkYg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=U0Gm44qjX6A0yDpeG8koHCPKNAkjW7bkIS8fYJtKEq1B3eamdHOdTmAFp0zEa41PPaRT6cYZyWuE6WDCCY+RJ9M0x4m5nUian5/ALSTHIWLq2gg3puom8ZjBm9KIMvuN2i3qOEnESfPHxNspYK6y8cXrYya1KRswJwhnjNn2R4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ZkigJbUQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OJWb7E3d; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ZkigJbUQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OJWb7E3d"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D18621400059;
	Tue,  3 Feb 2026 10:56:34 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 03 Feb 2026 10:56:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770134194;
	 x=1770220594; bh=wVp/m1Quz3BoFMxHOwcVsiCA1igA849JUDKjUESuUCI=; b=
	ZkigJbUQi4lP2PCPoPAYTUKlHopRZ0YwnspaEMVQfBCMEXpsJN6be9HBLUK/Jwh7
	8u+NDDjFVJ+GXyzCTtK/hGgtPwjK4uEajv0Q5aT4Co+Ox7IANF2kHag3h1TNqJOm
	/v4RZsFVY9peFJqNzmmlCDmch9lSVrIzXOZbakfcrSUlyPlpmr70aM3zaldLRoEx
	56pMN76Xrx444kUFJRayqLz6lxKn9wHzo4lsB8ulEtPi6cQ5kpe9QCq1gUJQdAeK
	LoWq5NBJBcy0Q2H0y0vBBUEjT9VcsV77pEtlA7nfQ1nNfugw6itdpPMhgHvu6Xy8
	xlwplA4lvT/QlROZ4pBl5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770134194; x=
	1770220594; bh=wVp/m1Quz3BoFMxHOwcVsiCA1igA849JUDKjUESuUCI=; b=O
	JWb7E3dwDuBQ6Oh/fanhwytDwxYiKR6r11AqTNLy5OhVBQErVkwFgzGKxHoYe2zz
	o82K2wG+06gOsBmKY5NRYuJb/QcCasNW7D8HB7O9GJwMh9JqUOV7c0UDorJHc/Bp
	+s+GQZjAiyyTe381spHXRC230fQFfb7ygWGWB56kYKaZa83Y/s12J99EpOSyLvIb
	Ms+FV7rq/hMTZNGatMKQ0CAqUKjXl3tDQPgKUcFl7UhAgtExCLOyr/FT3Dj6xpt8
	MAaHIYx0laH8z+16bCyFLtgKuxKsKLjbjBVcd4gKYvktYBmWrZH8I21dTaWjBN37
	FEaLhh8wF8UX0Kpq+AP9A==
X-ME-Sender: <xms:sRqCacLh9m__M0jBZiOdRimC0QMyHgO-yiWLQtGf2NDfb1PeCbs8tA>
    <xme:sRqCaW8_WbGQ84P6d5sjzJTC6BJj3famktU7GmylHEjP_EqWG4E9HONeIjar5f-OE
    1Xl2lsmlqtSa63V8FVF2Kz1TyO3FCZTGHqBgOHh4kiU-jyzbDXHy_kI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedtgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudelpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehmrghthhhivghurdguvghsnhhohigvrhhssegvfhhfihgtihhosh
    drtghomhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghp
    thhtoheprhguuhhnlhgrphesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlkh
    hpsehinhhtvghlrdgtohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhi
    htohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmhhhirhgrmhgrtheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhg
X-ME-Proxy: <xmx:sRqCaVgDVOeKcF55yIUFru0feO85XZRvRZP4d41NA7qVljXYrdsOtA>
    <xmx:sRqCae5TuNvu4rKojfZVpIOMUJTk5vD4mfPC3nY5AjGkG8YH6W0J5A>
    <xmx:sRqCadrYlx_rFWW6OA7wAk2Fyl10hAAqlWbEDD36CXpDQCZqJTyj4g>
    <xmx:sRqCabh_drFWdOszV0LArB7FQ_8FWUiHo3g4y2ha-bxOY6CGFQ26LA>
    <xmx:shqCac_5xk_bEmfYmm4PuL4Xl8VeV31qK2nsZXYcEAo1LfxXpEKFPBI5>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 772E5700065; Tue,  3 Feb 2026 10:56:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ATW73pPHePWN
Date: Tue, 03 Feb 2026 16:56:03 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "kernel test robot" <lkp@intel.com>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>, "Simon Horman" <horms@kernel.org>,
 "Jeff Layton" <jlayton@kernel.org>,
 "Anna Schumaker" <anna.schumaker@oracle.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Linux Memory Management List" <linux-mm@kvack.org>,
 "Randy Dunlap" <rdunlap@infradead.org>, "Yury Norov" <ynorov@nvidia.com>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Message-Id: <d777a8f0-41ab-48f8-93db-268f493ac656@app.fastmail.com>
In-Reply-To: <aYINAPJS9zXlUGCw@smile.fi.intel.com>
References: <20260202095834.1328352-1-arnd@kernel.org>
 <202602032036.FQK7gJvV-lkp@intel.com> <aYINAPJS9zXlUGCw@smile.fi.intel.com>
Subject: Re: [PATCH] tracing: remove __printf() attribute on __ftrace_vbprintk()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Feb 3, 2026, at 15:58, Andy Shevchenko wrote:
> On Tue, Feb 03, 2026 at 08:12:57PM +0800, kernel test robot wrote:
>
>> kernel test robot noticed the following build warnings:
>
> Yeah, you need to go for the full stack of these calls and mark the 
> bottom one with __diag() to avoid these warnings. That's my understanding
> and what BPF people required. Chasing this one-by-one would produce
> unneeded churn.

From what I can tell, I can just move the printf attribute
to the __ftrace_vbprintk() definition to make this bit work.
I'll send an updated patch:

--- a/kernel/trace/trace_printk.c
+++ b/kernel/trace/trace_printk.c
@@ -197,6 +197,7 @@ struct notifier_block module_trace_bprintk_format_nb = {
        .notifier_call = module_trace_bprintk_format_notify,
 };
 
+__printf(2, 3)
 int __trace_bprintk(unsigned long ip, const char *fmt, ...)
 {
        int ret;

There are unrelated warnings for BPF that I managed to
shut up the same way, doing

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b54ec0e945aa..45d026fc4e8a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1046,6 +1046,7 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
        return err;
 }
 
+__printf(3, 0)
 BPF_CALL_5(bpf_snprintf, char *, str, u32, str_size, char *, fmt,
           const void *, args, u32, data_len)
 {
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index 24730df55e69..816fd7fba3d2 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -212,6 +212,7 @@ __bpf_kfunc_start_defs();
  * Avoid using enum bpf_stream_id so that kfunc users don't have to pull in the
  * enum in headers.
  */
+__printf(2, 0)
 __bpf_kfunc int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args,
                                   u32 len__sz, struct bpf_prog_aux *aux)
 {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index eadaef8592a3..2d3de71ab86a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -359,6 +359,7 @@ static const struct bpf_func_proto bpf_probe_write_user_proto = {
 #define MAX_TRACE_PRINTK_VARARGS       3
 #define BPF_TRACE_PRINTK_SIZE          1024
 
+__printf(1, 0)
 BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
           u64, arg2, u64, arg3)
 {
@@ -412,6 +413,7 @@ const struct bpf_func_proto *bpf_get_trace_printk_proto(void)
        return &bpf_trace_printk_proto;
 }
 
+__printf(1, 0)
 BPF_CALL_4(bpf_trace_vprintk, char *, fmt, u32, fmt_size, const void *, args,
           u32, data_len)
 {
@@ -455,6 +457,7 @@ const struct bpf_func_proto *bpf_get_trace_vprintk_proto(void)
        return &bpf_trace_vprintk_proto;
 }
 
+__printf(2, 0)
 BPF_CALL_5(bpf_seq_printf, struct seq_file *, m, char *, fmt, u32, fmt_size,
           const void *, args, u32, data_len)
 {

Since those functions have no callers, the annotation on the
print functions does nothing.

With those added, and a couple of drivers fixed to use the
correct printf attributes, the only remaining one I see is
in samples/trace_events/trace-events-sample.h:

In file included from /home/arnd/arm-soc/include/trace/define_trace.h:132,
                 from /home/arnd/arm-soc/samples/trace_events/trace-events-sample.h:640,
                 from /home/arnd/arm-soc/samples/trace_events/trace-events-sample.c:12:
/home/arnd/arm-soc/samples/trace_events/./trace-events-sample.h: In function 'trace_event_get_offsets_foo_bar':
/home/arnd/arm-soc/include/trace/stages/stage5_get_offsets.h:33:31: error: function 'trace_event_get_offsets_foo_bar' might be a candidate for 'gnu_printf' format attribute [-Werror=suggest-attribute=format]
   33 |         { (void)sizeof(struct _test_no_array_##item *); }
      |                               ^~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/trace/trace_events.h:285:9: note: in definition of macro 'DECLARE_EVENT_CLASS'
  285 |         tstruct;                                                        \
      |         ^~~~~~~
/home/arnd/arm-soc/include/trace/trace_events.h:43:30: note: in expansion of macro 'PARAMS'
   43 |                              PARAMS(tstruct),                  \
      |                              ^~~~~~
/home/arnd/arm-soc/samples/trace_events/./trace-events-sample.h:291:1: note: in expansion of macro 'TRACE_EVENT'
  291 | TRACE_EVENT(foo_bar,
      | ^~~~~~~~~~~
/home/arnd/arm-soc/samples/trace_events/./trace-events-sample.h:299:9: note: in expansion of macro 'TP_STRUCT__entry'
  299 |         TP_STRUCT__entry(
      |         ^~~~~~~~~~~~~~~~
/home/arnd/arm-soc/samples/trace_events/./trace-events-sample.h:301:17: note: in expansion of macro '__field'
  301 |                 __field(        int,    bar                     )
      |                 ^~~~~~~
/home/arnd/arm-soc/samples/trace_events/./trace-events-sample.h: In function 'do_trace_event_raw_event_foo_bar':

I don't think this is related, but I also don't see an obvious
workaround other than forcing the warning off around that
definition.

       Arnd
