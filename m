Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793047658;
	b=dgoOn2AoPsme0Pkvz5VCnTZmeSEPrBQsSmjQDpTSIl9GG3nrdHfcOf91sD1sk8bfV0E5
	 d6sEUI6mHrQAnQpz37xFAvie8pLksmhpOWyEAkzzRbbYD3nlqdAPwjxuodXrPuK8b8EgX
	 JhjYiWGJXZTxvArV9e3def2ExsMN63cMC8oUM8VM72FjTEPm3zYRSeH5h/Ofm1h6oX21j
	 GovfQwuDFg9rlmqzv2KnE0SPdUykEbGroH6R+aBJ+waXNtsUI909I1CP1HRs/bKTQRDYA
	 TPKJxEt9sCp8sTjKwoOdRLhjSC76YUtwgDyibufI/54G+qszVHRL1/TrYv77a5kAOow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793047658;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=bi/dF0duPNIpFPP0XBhAUfWsF3W0vUPh0zZaQpp5mnU=;
	b=XgRVWwyAoYypIuyyJ5ZyJ/E2nLcI3rk44bsAPHjZoVg/fr+B7T9ZlqwmgYxmBoFeZM9S
	 qGLflVcYwhJuJkbujZgqegSa3YVvtmhgGLLkOPb8A+tGp7RjlkGJ4dU4KMmEtxJGoBxkk
	 azVntRfVKqm8boVqe00GlAvpC6Rfy0UMGZ8qgO1SUNw/fbG0XamRy7kYqeVReNwhhep+h
	 lXjccMlVQz5GTSNFhjlqWLYC8l7a7lq6cJQ2gARuxibZii4Z3XvIhk652Ilea4SO/UKZ9
	 fK43zrL1EYjyZYGH2hK6VqhYeFbI90LVIcU0nji01bJNsGovfDiNVE3zKOhp4EubciQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=Jt6bDdKM;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA4D606A31A;
	Mon, 26 Oct 2026 20:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECA4D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=Jt6bDdKM
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 75203A0810;
	Mon, 26 Oct 2026 20:47:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id AABB420026;
	Mon, 26 Oct 2026 20:47:33 +0000 (UTC)
Date: Mon, 26 Oct 2026 16:47:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 6/9] tracing/filters: Skip second character of '&&'
 and '||' in calc_stack()
Message-ID: <20261026164727.0d1636cb@gandalf.local.home>
In-Reply-To: <179291748555.492959.3275503783612449972.stgit@devnote2>
References: <179291742944.492959.11659339795290028998.stgit@devnote2>
	<179291748555.492959.3275503783612449972.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: q6cg4rk9fn5igcqzm4ab8txy8re7sjjt
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: AABB420026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19vVCx3D5Mg3/w52xBtHaqIJ/CilWYSCkA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=bi/dF0duPNIpFPP0XBhAUfWsF3W0vUPh0zZaQpp5mnU=; b=Jt6bDdKMJ3KQmIG0f4XKsO/MT2SC2coYmryQPkvtir3BrdZTt+J+3H7rmlbcQ7VbrBOkdVdcgJIrlW0Va0v5RtDIwrxQNoJBdz3nHi85QXkqKCJnA8X0n3XrXmaxWXSPc9g8N3IfZ2I/Eo/aEBIYU4kzMrFGM9Uu0u6/CQX5mew=
X-HE-Tag: 1793047653-986889
X-HE-Meta: U2FsdGVkX1+YncBO4JaXPsoWfzD4EEYZJ/odPV9r4TDTsT83HgYihm3bjVsRPDErdXmGDDrjk4SVhmTVJvr/TvkjI+RSX+h5CDUYTn9L2xmRaVa5GKEfhj1GCq2ALxK0RnGV5YZ7M9+RVxuYXewLF8anT+1YI/DwvS6tbP6WE53vhZ8RX6TcBzIgm3X2bZNOlo21MS2qZJHoJCVwcHSUWsLFr0U+Lz9MHyCRnIQUrkDcrIgZ4SwPQwrMBBJpLwAQZcTecE3UkrIda1OaGMt5kVwxj07QbeEU3y0GYam3CNUCJrl90eiZvGc75ZFBiJqbDeHem6fkhdmKhZs4EAzdMW12iM5kphCz

On Sun, 25 Oct 2026 17:38:05 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> In calc_stack(), when encountering '||' or '&&' (where str[i+1] == str[i]),
> the loop sets 'is_pred = false' and continues without advancing 'i' past
> the second character of the operator. On the next iteration, the second '|'
> or '&' sees str[i+1] != str[i], breaks out of the switch statement, and is
> counted as the start of a new predicate (incrementing nr_preds and setting
> is_pred = true).
> 
> Consequently, a trailing logical operator (e.g. 'common_pid == 1 ||') is
> counted as having 2 predicates instead of 1, and any subsequent non-space
> character before a delimiter fails to increment nr_preds.

 "common_pid ||' is an invalid expression.

> 
> Increment 'i' when matching '||' or '&&' so the entire two-character
> operator is skipped.

This is just wrong.

Masami, don't blindly trust AI.

I purposely did it this way. Because && and || creates a new predicate.

 If you have "x||y"
              ^
              i

 Start with i = 0; is_pred = false; nr_preds = 0;

   str[i] == 'x'
   if (!is_pred) {
	nr_preds++;  // nr_preds = 1
        is_pred = true;
   }

 in for loop i++;  // i = 1; str[i] = '|'

   switch (str[i])
   case '|':
      if (str[i+1] != str[i]) // false
      is_pred = false;
      continue;

 in for loop i++; // i = 2; str[i] == '|';

   switch (str[i])
   case '|':
      if (str[i+1] != str[i]) // true
          break;

   if (!is_pred) {
	nr_preds++;  // nr_preds = 2
        is_pred = true;
   }

 in for loop i++; // i = 3; str[i] == 'y';
 
   if (!is_pred) { // false because is_pred == true

Loop ends.

nr_preds == 2. This is correct.

This patch is garbage.

-- Stevwe



> 
> Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_events_filter.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index 3bd0b47a627f..bcd37fd6c109 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -2208,6 +2208,7 @@ static int calc_stack(const char *str, int *parens, int *preds, int *err)
>  		case '&':
>  			if (str[i+1] != str[i])
>  				break;
> +			i++;
>  			is_pred = false;
>  			continue;
>  		case '(':

