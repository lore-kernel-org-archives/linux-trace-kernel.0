Received: from business190-3.web-hosting.com (business190-3.web-hosting.com [66.29.153.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AD9302767;
	Fri, 16 Oct 2026 08:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.29.153.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792139299; cv=none; b=F++uw5CxzPimti+oy2nno+w0UbogKcll2ZxJGzQFhK3+AjdHggLkjMeYSSIWRF1w6nE5Zwl207TLwNbpC/8RMp0y6QPZKrrm/Wf/evltTrVerEyq06vVBg0vmt2r0vuO3/LHkNk+3FmVuB0HuT7r+PRDMRF6e1MJGrM/1kKBFZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792139299; c=relaxed/simple;
	bh=6LV9wLOnGQtumPmVokzYVkAPy2/Dg57Wk2EpoYUlbTo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=bQCWr/Z+hn+KJ3Dyqs4RAKtCDUiv5udEsmCXMK+5aRU8LRuEu5qpxU0oTZ31sqObL8y9kdTAp1r/+dlqG2jkRMUarP9NiLuWKaLJ40wvphz7wcpdK6U349ZBShn5NvXPBhCOl3WgDxAyxLFyWgKQeZlOUGWbw6v7F/dGC6u86Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mathgraph.org; spf=pass smtp.mailfrom=mathgraph.org; dkim=pass (2048-bit key) header.d=mathgraph.org header.i=@mathgraph.org header.b=FhUv+qHp; arc=none smtp.client-ip=66.29.153.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mathgraph.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mathgraph.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mathgraph.org header.i=@mathgraph.org header.b="FhUv+qHp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mathgraph.org; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=Kx2v3a8EiiKPqdJGZPX5lUJcVkR1MUr1WjyMhou2L0s=; b=FhUv+qHpa4e5
	qbHf0z3/Nwf39FGvLLQ81MNxo9BoRxx4/+FmpISTvPyOHougl4Ohgo6U+zt3/oEQYAPBFlpcUdKmA
	ewUVnMbyQwIQFfjmeytrejA+wydqT/eiULpnYKeFkU/PtDE+UzjWdSs6u50BIxoG3L9l7bnayPc0W
	01WfW+Rtq1/4zp+59saUwzgfCdcUQZcO3kSxDOoCkuGEABRW8bzxUCAC/ObtuKn8ZqzhMECZ2EhnU
	3KSxMklKJBurYYUg7mKCvv7PbdWcwAk0zl9/NmlzTOKPzCLEVmD+cT9wKqm/CFhJv2g8qlIqdw+0I
	7XSwoh0Ob1oNOY/E6IAHng==;
Received: from [::1] (port=47094 helo=business190.web-hosting.com)
	by business190.web-hosting.com with esmtpa (Exim 4.100.1)
	(envelope-from <heath@mathgraph.org>)
	id 1xHdIN-0000000Fozb-0sqk;
	Fri, 16 Oct 2026 04:28:07 -0400
Received: from cgn-ote149-19-21-226.as55850.net ([149.19.21.226])
 via cgn-ote149-19-21-226.as55850.net ([149.19.21.226])
 by business190.web-hosting.com
 with HTTP (HTTP/1.1 POST); Fri, 16 Oct 2026 04:28:06 -0400
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 16 Oct 2026 04:28:06 -0400
From: heath@mathgraph.org
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] verification/rvgen: reject ambiguous state/event
 transitions
In-Reply-To: <9fc2d6a03fabc2c756bfa696bc907ef23dcc175a.camel@redhat.com>
References: <11d37dced04f512153c023b8b7361309@mathgraph.org>
 <9fc2d6a03fabc2c756bfa696bc907ef23dcc175a.camel@redhat.com>
User-Agent: Roundcube Webmail/1.6.19
Message-ID: <f8a773ce204c7dfe5b15bdefe21131b1@mathgraph.org>
X-Sender: heath@mathgraph.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - business190.web-hosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mathgraph.org
X-Get-Message-Sender-Via: business190.web-hosting.com: authenticated_id: heath@mathgraph.org
X-Authenticated-Sender: business190.web-hosting.com: heath@mathgraph.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched

Thanks, Gabriele! Really appreciate you taking the patch and the 
clarification on LLM disclosures.

One small question- this work is part of MathGraph, developed at 
Metalogic Labs. Is there a conventional way to acknowledge that 
affiliation in the commit? No worries at all if not — I wouldn’t want to 
complicate or delay the patch.

Thanks again!

Heath Sanchez
Metalogic Labs | MathGraph
https://mathgraph.org

On 2026-10-16 03:55, Gabriele Monaco wrote:
> On Tue, 2026-10-13 at 15:51 -0400, heath@mathgraph.org wrote:
>> The rvgen generator builds a transition table indexed by source state
>> and event. A DOT specification with different destinations for the 
>> same
>> key is currently accepted, and the selected destination depends on the
>> iteration order of parsed transitions.
>> 
>> Reject duplicate state/event keys after sorting the transitions, 
>> before
>> generating the monitor. This prevents silently selecting an arbitrary
>> destination without changing valid automata.
>> 
>> OpenAI GPT-6 assisted in finding the issue, developing the fix and
>> tests,
>> and drafting the changelog. I reviewed the changes and take
>> responsibility
>> for this contribution.
>> 
>> Fixes: cad252db78a9 ("verification/rvgen: Switch __create_matrix() to
>> Lark")
>> Assisted-by: LLM
>> Signed-off-by: Heath Sanchez <heath@mathgraph.org>
> 
> Thanks for the quick V2. I'm going to take this.
> 
> As a side note, I just read ([1], subscription required) that the 
> Maintainers
> decided at the 2026 Summit that models used and other LLM details are 
> no longer
> to be included in the changelog.
> 
> You don't need to send a V3, I'm trimming that paragraph. Anyway this 
> kind of
> transparency is largely appreciated, so feel free to include it after 
> the --- on
> your next contributions.
> 
> Thanks,
> Gabriele
> 
> [1] - https://lwn.net/Articles/1099594
> 
>> ---
>> Changes in v2:
>> - Drop the redundant hybrid-automaton regression fixture and test.
>> - Match the full traceback prefix in the negative assertion.
>> - Move detailed qualification results outside the permanent changelog.
>> 
>> Verification: original rvgen suite 30/30; revised suite 31/31;
>> 64 deterministic/hybrid hash-seed replays rejected malformed models.
>> https://github.com/metalogiclabs/mathgraph/actions/runs/38452477359
>> 
>> diff --git a/tools/verification/rvgen/rvgen/automata.py
>> b/tools/verification/rvgen/rvgen/automata.py
>> index fd37ce3..1f9a56a 100644
>> --- a/tools/verification/rvgen/rvgen/automata.py
>> +++ b/tools/verification/rvgen/rvgen/automata.py
>> @@ -418,6 +418,13 @@ class Automata:
>>                   transitions.append(Transition(src, dst, event, 
>> reset,
>> rule))
>> 
>>           transitions.sort(key=lambda t : (t.src, t.event))
>> +        previous_key = None
>> +        for transition in transitions:
>> +            key = (transition.src, transition.event)
>> +            if key == previous_key:
>> +                raise AutomataError(
>> +                    f"Duplicate transition for event 
>> {transition.event}
>> in state {transition.src}")
>> +            previous_key = key
>>           return transitions
>> 
>>       def __parse_states(self):
>> diff --git a/tools/verification/rvgen/tests/rvgen_monitor.t
>> b/tools/verification/rvgen/tests/rvgen_monitor.t
>> index 5f25626..8d635fc 100644
>> --- a/tools/verification/rvgen/tests/rvgen_monitor.t
>> +++ b/tools/verification/rvgen/tests/rvgen_monitor.t
>> @@ -84,4 +84,9 @@ check "invalid ltl file syntax" \
>>   	"$RVGEN monitor -c ltl -s tests/specs/test_invalid.ltl -t per_task" 
>> 1
>> \
>>   	"No terminal matches 'i'" "Traceback (most recent call last)"
>> 
>> +# Reject ambiguous source state/event pairs.
>> +check "reject conflicting deterministic automaton transitions" \
>> +	"$RVGEN monitor -c da -s tests/specs/test_nondeterministic_da.dot -t
>> per_cpu" 1 \
>> +	"Duplicate transition for event event_2 in state state_a" "Traceback
>> (most recent call last)"
>> +
>>   test_end
>> diff --git
>> a/tools/verification/rvgen/tests/specs/test_nondeterministic_da.dot
>> b/tools/verification/rvgen/tests/specs/test_nondeterministic_da.dot
>> new file mode 100644
>> index 0000000..1b63b5d
>> --- /dev/null
>> +++ 
>> b/tools/verification/rvgen/tests/specs/test_nondeterministic_da.dot
>> @@ -0,0 +1,16 @@
>> +digraph state_automaton {
>> +	{node [shape = circle] "state_b"};
>> +	{node [shape = plaintext, style=invis, label=""] "__init_state_a"};
>> +	{node [shape = doublecircle] "state_a"};
>> +	{node [shape = circle] "state_a"};
>> +	"__init_state_a" -> "state_a";
>> +	"state_a" [label = "state_a"];
>> +	"state_a" -> "state_a" [ label = "event_2" ];
>> +	"state_a" -> "state_b" [ label = "event_2" ];
>> +	"state_b" [label = "state_b"];
>> +	"state_b" -> "state_a" [ label = "event_2" ];
>> +	{ rank = min ;
>> +		"__init_state_a";
>> +		"state_a";
>> +	}
>> +}
