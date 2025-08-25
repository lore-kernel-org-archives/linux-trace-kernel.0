Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8242D5C61;
	Mon, 25 Aug 2025 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115759; cv=none; b=bTUwzBmDm619yDudTLD8mtPjAbrbgaNXI1uHUwpKN13YWiJDhwbiz1WFyQBE8O9vUcLAE82/sgxZ1AY5DYtr5NSzHuCI+2pU4Hki8UYIM7NHCvkh3QhJ012xDn544GBDzNBya1+ZcnvqPgBeB05Nsr4Wz87d5KMYCAILPMxtI5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115759; c=relaxed/simple;
	bh=lGtfrfvnQoIdGQLhHh0iDxDrXu9sMFUP/0SzVV1kF0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEfFdPgRYE+PFsGb24B9FjUyb7bRAkYNbilib/inqMwjp3MQJ+ojlqTWEVorxhtHuae8lcLrwoKwSMyULMSDfwupRtfekRVyJVprA5SIgGduAnxB7pAboUF6lMe3vyhprktdr8h9aMXwUvrr2OTEQfEl26ZbiZaG5hQ14rw78IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oQlDCHn2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vXkJ7c72; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oQlDCHn2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vXkJ7c72"
Date: Mon, 25 Aug 2025 11:55:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756115755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CsNwdNgt3Cei2kSkCLTX8Ma530gKjb02dgxqfB6hDPI=;
	b=oQlDCHn2OlPwtBW4P3lwkPyqzKy+TavDqQ12oRJV84vXGaoH6cqInOnH5/Jqo0+NDBwk4J
	e28JIQoiP8E2HtD2JKFT3qdBOhd1ICO8WkWFoGs1Xi4NMs8NZC/EDXzIq+ade/xbn006oQ
	qM94cXEGYZR97eyinNcOCjUgVQp40YYpnxHi94H09VAznHJL4wWrGb3I7D7qUFFpxD7865
	+jXKxkgFYNXjGGrUSE+Ompad7OLMnI7bGObcIc8ydnx28YbXshTndofCT1jKRFTi6huDoH
	CwberaSkf6ia8DQL+Xot7+0DLcKulEEr0Rfnl682/dmhqQml/0obR8HG2ayiUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756115755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CsNwdNgt3Cei2kSkCLTX8Ma530gKjb02dgxqfB6hDPI=;
	b=vXkJ7c72/7t9acwpYY6I7dtH+Gwgqgu26Ya7jWua/R5DRIS5ecsDJG3sTUCOOBrpih8SOH
	NJLPkSX+tZvzonDw==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 10/17] verification/rvgen: Add support for Hybrid
 Automata
Message-ID: <20250825095554.NrT5tNY8@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-11-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814150809.140739-11-gmonaco@redhat.com>

On Thu, Aug 14, 2025 at 05:08:02PM +0200, Gabriele Monaco wrote:
>                  for i in event.split("\\n"):
> +                    if ";" in i:
> +                        # if the event contains a constraint (hybrid automata),
> +                        # it will be separated by a ";":
> +                        # "sched_switch;x<1000;reset(x)"
> +                        line = i.split(";")
> +                        i = line.pop(0)
> +                        if len(line) > 2:
> +                            raise ValueError("Only 1 constraint and 1 reset are supported")
> +                        envs += self.__extract_env_var(line)
>                      events.append(i)

How about we get rid of the (if ";"), and just split it:

for i in event.split("\\n"):
    # if the event contains a constraint (hybrid automata),
    # it will be separated by a ";":
    # "sched_switch;x<1000;reset(x)"
    line = i.split(";")
    events.append(line.pop(0))
    if len(line) > 2:
            raise ValueError("Only 1 constraint and 1 reset are supported")
        envs += self.__extract_env_var(line)

> +            else:
> +                # state labels have the format:
> +                # "enable_fired" [label = "enable_fired\ncondition"];
> +                #  ----- label is here -----^^^^^
> +                # label and node name must be the same, condition is optional
> +                state = self.__dot_lines[cursor].split("label")[1].split('"')[1]

I know I complained about regex last week, but for this case I think regex
is more suitable:

state = re.findall(r'".*?" \[label = "([^"]*)"\]', self.__dot_lines[cursor])[0]

> +                if "\\n" in state:
> +                    line = state.split("\\n")
> +                    line.pop(0)
> +                    if len(line) > 1:
> +                        raise ValueError("Only 1 constraint is supported in the state")
> +                    envs += self.__extract_env_var([line[0].replace(" ", "")])

Same as above, I think we can just split without the if check.

>              cursor += 1
>  
> -        return sorted(set(events))
> -
> -    def __create_matrix(self):
> +        return sorted(set(events)), sorted(set(envs))
> +
> +    def _split_constraint_expr(self, constr: list[str]) -> Iterator[tuple[str,
> +                                                                          str | None]]:
> +        """
> +        Get a list of strings of the type constr1 && constr2 and returns a list of
> +        constraints and separators: [[constr1,"&&"],[constr2,None]]
> +        """
> +        exprs = []
> +        seps = []
> +        for c in constr:
> +            while "&&" in c or "||" in c:
> +                a = c.find("&&")
> +                o = c.find("||")
> +                pos = a if o < 0 or 0 < a < o else o
> +                exprs.append(c[:pos].replace(" ", ""))
> +                seps.append(c[pos:pos+2].replace(" ", ""))
> +                c = c[pos+2:].replace(" ", "")
> +            exprs.append(c)
> +            seps.append(None)
> +        return zip(exprs, seps)

If && and || are the only things you intend to support, then this is
probably okay. But if the syntax will ever be extended (e.g. brackets),
this becomes unreadable really fast.

Perhaps a "real" parser which converts the input string into abstract
syntax tree is something worth considering.

> +    def is_event_constraint(self, key: tuple[int, int] | int) -> bool:
> +        """
> +        Given the key in self.constraints return true if it is an event
> +        constraint, false if it is a state constraint
> +        """
> +        return isinstance(key, tuple)

I don't love this. A few years from now, someone could change state
constraint to be a tuple, or change event contraint to not be tuple, and
things break in confusing ways.

Perhaps an explicit variable to store contraint type information instead?

> -    def __get_enum_states_content(self):
> +    def __get_enum_states_content(self) -> list[str]:
>          buff = []
>          buff.append("\t%s%s = 0," % (self.initial_state, self.enum_suffix))
>          for state in self.states:
> @@ -36,7 +37,7 @@ class Dot2c(Automata):
>  
>          return buff
>  
> -    def format_states_enum(self):
> +    def format_states_enum(self) -> list[str]:
>          buff = []
>          buff.append("enum %s {" % self.enum_states_def)
>          buff += self.__get_enum_states_content()
> @@ -58,7 +59,7 @@ class Dot2c(Automata):
>  
>          return buff
>  
> -    def format_events_enum(self):
> +    def format_events_enum(self) -> list[str]:

These changes should be in your type annotation patch?

>          buff = []
>          buff.append("enum %s {" % self.enum_events_def)
>          buff += self.__get_enum_events_content()
> @@ -66,7 +67,43 @@ class Dot2c(Automata):
>  
>          return buff
>  
> -    def get_minimun_type(self):
> +    def __get_non_stored_envs(self) -> list[str]:
> +        return [ e for e in self.envs if e not in self.env_stored ]
> +
> +    def __get_enum_envs_content(self) -> list[str]:
> +        buff = []
> +        first = True
> +        # We first place env variables that have a u64 storage.
> +        # Those are limited by MAX_HA_ENV_LEN, other variables
> +        # are read only and don't require a storage.
> +        unstored = self.__get_non_stored_envs()
> +        for env in list(self.env_stored) + unstored:
> +            if first:
> +                buff.append("\t%s%s = 0," % (env, self.enum_suffix))
> +                first = False
> +            else:
> +                buff.append("\t%s%s," % (env, self.enum_suffix))

The "= 0" assignment for the first enum is not required right? Perhaps you
can get rid of the 'first" thingy, and just do

for env in list(self.env_stored) + unstored:
    buff.append("\t%s%s," % (env, self.enum_suffix))

> +        match unit:
> +            case "us":
> +                value *= 1000
> +            case "ms":
> +                value *= 1000000
> +            case "s":
> +                value *= 1000000000

Since when did Python have this? Nice!

Nam
