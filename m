Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658DA1E9919;
	Tue, 15 Jul 2025 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591721; cv=none; b=Fq2e9TZABd7VYIASh6fVWUfR4mZ0mh0a99R94LNY5eVT/AYEZSAiBBPyUGGPXtyx1zn3WDsJtcilALjQTpqy9/JsS1OJwq6KWgQ8CmAbebN52WQqpAYONJujUObSi3ZXPdv1BrFmaTcpkJN2pdFOrdz7twWNDSRiUkeOuETno+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591721; c=relaxed/simple;
	bh=PRvkD8XVZv1RvZqERZNXA2sjtIt0PfIn1JIiotXt9JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWjHLur3iqhrIdPj21JcTPOL3wtjjLSYdIQKkFI9GWWFZbeiPIO6rRm99/eUaepKmY0mWzyCMM3WTThfsJCFpfl5U55CNGcOl9tUuohdtiveUI3wS28araDlp8UsaCHmOShXQ+ygNDJvZ0+o8+oo7Wv+hKC8KIT6sWVoR/t9BAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bpLD4pJf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tBZ9aDzi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bpLD4pJf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tBZ9aDzi"
Date: Tue, 15 Jul 2025 17:01:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752591717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wRUwhx3/O+f9RFnLnKg1E1i1cjkfzjTWs1h01zmf0fo=;
	b=bpLD4pJfc5EQiK9rQ0hId+EfUWeAR8TSXkTmwWrZNaoR0IfKEQOzAUQuTDZ2Ixt/RzqDDM
	5lNWTvKrIhTb0WM3J1ql9i7LMT+NMVyIe6NrqU69V8uSmiicqHqn7OaC7k59bBBNfnxA94
	C3geNwX6xQxnaGlG/BL+LWeP2jmAtivaxoVdJKTXHd6FjWLn/MleZjvDI9MqOlAC7Yh2X9
	PbaU56Eg0qHZ2Ub+0BVhMjf+vwkBM0n5nPs/hkugP2JKboHNfpxnQHqkchuyZ+oTPok34J
	2HhWrqv2uYhyUHavjUay4DKrQuBwYcmBNAomF0wKgI5UONmZxZym98ZhpKm2yA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752591717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wRUwhx3/O+f9RFnLnKg1E1i1cjkfzjTWs1h01zmf0fo=;
	b=tBZ9aDzilEg1BSc7YzrTjS16MgykLcAud6I6R5cIihhZVN73cBJm69EotHnN9zjQjOpELE
	auTSrfZP6p0jBZCQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 09/17] tools/dot2c: Fix generated files going over 100
 column limit
Message-ID: <20250715150156.QXAD4dZl@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
 <20250715071434.22508-10-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715071434.22508-10-gmonaco@redhat.com>

On Tue, Jul 15, 2025 at 09:14:26AM +0200, Gabriele Monaco wrote:
> From: Nam Cao <namcao@linutronix.de>

You seem to take a slightly different solution. Feel free to take my name
off the author field, Co-developed-by: or Suggested-by: would be fine. It's
up to you, doesn't really matter to me.

> The dot2c.py script generates all states in a single line. This breaks the
> 100 column limit when the state machines are non-trivial.
> 
> Change dot2c.py to generate the states in separate lines in case the
> generated line is going to be too long.
> 
> Co-authored-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>  tools/verification/rvgen/rvgen/dot2c.py | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/verification/rvgen/rvgen/dot2c.py b/tools/verification/rvgen/rvgen/dot2c.py
> index 6009caf568d92..5216d98ae21c8 100644
> --- a/tools/verification/rvgen/rvgen/dot2c.py
> +++ b/tools/verification/rvgen/rvgen/dot2c.py
> @@ -152,28 +152,29 @@ class Dot2c(Automata):
>          max_state_name = max(self.states, key = len).__len__()
>          return max(max_state_name, self.invalid_state_str.__len__())
>  
> -    def __get_state_string_length(self):
> -        maxlen = self.__get_max_strlen_of_states() + self.enum_suffix.__len__()
> -        return "%" + str(maxlen) + "s"
> -
>      def get_aut_init_function(self):
>          nr_states = self.states.__len__()
>          nr_events = self.events.__len__()
>          buff = []
>  
> -        strformat = self.__get_state_string_length()
> -
> +        maxlen = self.__get_max_strlen_of_states() + len(self.enum_suffix)
> +        # account for tabs and spaces/punctuation for each event
> +        linetoolong = 16 + (maxlen + 3) * nr_events >= self.line_length

I managed to figure out 16 is the indentation. But I failed to understand
where is this '3' from.

Can you please add some comments for these magic numbers? Or better, assign
them to variables with self-explanatory names.

Best regards,
Nam
