Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74EB386C3E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 19:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872053; cv=none; b=SRn17sDYESPoKcB3o+40VZ4tVizt9AiiradbH36v3l4DnVZDjLwsaEMA2wkw+uyh8AXkROBaYDEcILETIwYncVAYZ+A56EUIsWk+4yKnq1qq/2WNyZfqxuocBaMD9Jf5xTgqd8uIdCfDFg5imrfyNQQeFtk63XqHJJOZtGGS/ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872053; c=relaxed/simple;
	bh=gnmffbwsWBQwSPvo5r8w2VgNXePM8iLuHQIx2ta9RQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NIXonXZ8tcoO736wmaMz1OMAv/eO2HprTIof8Oypridtl4D3SeEPrUl7A+ar8EkmW3ykum2py5dOPayYf6BoOy9eTSdZNNlTpI1gWBGquQ+gq/IZnYBUkkYUHTed2Otc8kEl4MUaDjcMGofLcZPcNdvTAL+pGvlQvsCPcg356nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dUdtnA9X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUdtnA9X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778872050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K0FPAPc/dHgDnKZYMzlgAQceKzm1L8rMYvB4SPhOEFQ=;
	b=dUdtnA9XBE+rboKYptG7LOvq8+DTU3fyxRl+F05xIQyXDEDnSXaLN83ZWSLauB+qvIKtE1
	3MWa01MkofoVvilNDzBB8y6oR4IbyYrAym4mvuFhEH2uDFlkP8B+Zde3sbUWJk0vUy2ppm
	dYp7g7/mWSZgqBGyTw8qwYpaKddAQjs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-USygjF4DPlSK63SBXo27kg-1; Fri,
 15 May 2026 15:07:26 -0400
X-MC-Unique: USygjF4DPlSK63SBXo27kg-1
X-Mimecast-MFC-AGG-ID: USygjF4DPlSK63SBXo27kg_1778872045
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9204D19560BB;
	Fri, 15 May 2026 19:07:25 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.80.107])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 570331956053;
	Fri, 15 May 2026 19:07:23 +0000 (UTC)
Date: Fri, 15 May 2026 16:07:21 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] verification/rvgen: Implement state and transition
 parser based on Lark
Message-ID: <agdtxdk-JSyGLZ6o@wcosta-defaultstring.rmtbr.csb>
References: <cover.1777962130.git.namcao@linutronix.de>
 <361efb610ba7c06b3668a953a6847ea80453c2e3.1777962130.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <361efb610ba7c06b3668a953a6847ea80453c2e3.1777962130.git.namcao@linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: wqBd-6vrsOEOAKgfpAYDp5YCVme8Tk4BN31e8vmAgoA_1778872045
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 05, 2026 at 08:59:24AM +0200, Nam Cao wrote:
> The DOT parsing scripts directly parse the raw text and they are quite
> fragile. If the input dot files' formats are slightly changed (for
> instance, by breaking long some lines which is allowed by the DOT
> language), the scripts would fail.
> 
> Prepare to move away from the raw text processing, implement parsers based
> on Lark which parse states, transitions and constraints.
> 
> The parse results are not used yet. The existing scripts will be converted
> one by one to them, and the raw text processing will eventually be removed.
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  tools/verification/rvgen/rvgen/automata.py | 207 +++++++++++++++++++++
>  1 file changed, 207 insertions(+)
> 
> diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
> index 4e3d719a0952..32c16736a41b 100644
> --- a/tools/verification/rvgen/rvgen/automata.py
> +++ b/tools/verification/rvgen/rvgen/automata.py
> @@ -194,6 +194,155 @@ class ParseTree:
>          self.node_attrs = attributes_parser.node_attrs
>          self.edge_attrs = attributes_parser.edge_attrs
>  
> +class ConstraintCondition:
> +    def __init__(self, env: str, op: str, val: str, unit=None):
> +        self.env = env
> +        self.op = op
> +        self.val = val
> +        self.unit = unit
> +        if unit is None:
> +            # try to infer unit from constants or parameters
> +            val_for_unit = val.lower().replace("()", "")
> +            if val_for_unit.endswith("_ns"):
> +                self.unit = "ns"
> +            if val_for_unit.endswith("_jiffies"):
> +                self.unit = "j"
> +
> +class ConstraintRule:
> +    grammar = r'''
> +        rule: condition (OP condition)*
> +
> +        OP: "&&" | "||"
> +
> +        condition: ENV CMP_OP VAL UNIT?
> +
> +        ENV: CNAME
> +
> +        CMP_OP: "==" | "<=" | "<" | ">=" | ">"
> +
> +        VAL: /[0-9]+/
> +           | /[A-Z_]+\(\)/
> +           | /[A-Z_]+/
> +           | /[a-z_]+\(\)/
> +           | /[a-z_]+/
> +
> +        UNIT: "ns" | "us" | "ms" | "s"
> +    '''
> +
> +    def __init__(self, c: ConstraintCondition):
> +        '''
> +        A list of pairs of
> +          - the condition (e.g. is_constr_dl == 1)
> +          - the logical operator ("||" or "&&") combining this
> +            condition with the next one if it exists, otherwise None
> +
> +        TODO: Perhaps use an abstract syntax tree instead, because
> +              this representation cannot capture precedence
> +        '''
> +        self.rules = [[c, None]]

Here self.rules is a list of lists...

> +
> +    def chain(self, op: str, c: ConstraintCondition):
> +        self.rules[-1][1] = op
> +        self.rules.append((c, None))

... but here it is a list of tuples.

> +
> +class ConstraintReset:
> +    def __init__(self, env):
> +        self.env = env
> +
> +class StateLabelParser:
> +    grammar = r'''
> +    label: CNAME ("\\n" condition)?
> +
> +    %import common.CNAME
> +    %import common.WS
> +    %ignore WS
> +    ''' + ConstraintRule.grammar
> +
> +    def __init__(self, label: str):
> +        parser = lark.Lark(self.grammar, parser='lalr', start="label")
> +        tree = parser.parse(label)
> +
> +        self.state = tree.children[0]
> +        self.constraint = None
> +
> +        if len(tree.children) == 2:
> +            self.constraint = ConstraintCondition(*tree.children[1].children)
> +            if self.constraint.op not in ("<", "<="):
> +                raise AutomataError("State constraints must be clock expirations like"
> +                                    f" clk<N ({label})")
> +
> +class EventLabelParser:
> +    grammar = r'''
> +    events: event ("\\n" event)*
> +
> +    event: name (";" guard)*
> +
> +    guard: reset
> +         | rule
> +         | rule reset
> +         | reset rule
> +
> +    name: CNAME
> +
> +    reset: "reset" "(" ENV ")"
> +
> +    %import common.CNAME
> +    %import common.WS
> +    %ignore WS
> +    ''' + ConstraintRule.grammar
> +
> +    class GetEvents(lark.visitors.Transformer):
> +        def guard(self, args):
> +            reset = None
> +            rule = None
> +            for arg in args:
> +                if arg.data == "reset":
> +                    reset = ConstraintReset(arg.children[0])
> +                elif arg.data == "rule":
> +                    conditions = arg.children
> +                    rule = ConstraintRule(conditions[0])
> +                    for i in range(1, len(conditions), 2):
> +                        rule.chain(conditions[i], conditions[i + 1])
> +            return reset, rule
> +
> +        def OP(self, args):
> +            return args
> +
> +        def condition(self, args):
> +            return ConstraintCondition(*args)
> +
> +        def event(self, args):
> +            name = args[0]
> +            rule, reset = None, None
> +            if len(args) == 2:
> +                reset, rule = args[1]
> +            return name, reset, rule
> +
> +        def events(self, args):
> +            return args
> +
> +        def name(self, args):
> +            return args[0]
> +
> +    def __init__(self, label: str):
> +        parser = lark.Lark(self.grammar, parser='lalr', start="events")
> +        tree = parser.parse(label)
> +        self.events = self.GetEvents().transform(tree)
> +
> +class Transition:
> +    def __init__(self, src: str, dst: str, event: str,
> +                 reset: ConstraintReset, rule: ConstraintRule):
> +        self.src = src
> +        self.dst = dst
> +        self.event = event
> +        self.rule = rule
> +        self.reset = reset
> +
> +class State:
> +    def __init__(self, name: str, inv: ConstraintRule):
> +        self.name = name
> +        self.inv = inv
> +
>  class _ConstraintKey:
>      """Base class for constraint keys."""
>  
> @@ -248,6 +397,8 @@ class Automata:
>          self.name = model_name or self.__get_model_name()
>          self.__dot_lines = self.__open_dot()
>          self.__parse_tree = ParseTree(file_path)
> +        self.transitions = self.__parse_transitions()
> +        self._states, self._initial_state, self._final_states = self.__parse_states()
>          self.states, self.initial_state, self.final_states = self.__get_state_variables()
>          self.env_types = {}
>          self.env_stored = set()
> @@ -323,6 +474,62 @@ class Automata:
>  
>          return cursor
>  
> +    def __parse_transitions(self):
> +        transitions = []
> +
> +        for edge in self.__parse_tree.edges:
> +            attr = self.__parse_tree.edge_attrs.get(edge)
> +            if not attr:
> +                continue
> +
> +            label = attr.get("label")
> +
> +            src, dst = edge
> +
> +            parser = EventLabelParser(label)
> +            for event, reset, rule in parser.events:
> +                transitions.append(Transition(src, dst, event, reset, rule))
> +
> +        transitions.sort(key=lambda t : (t.src, t.event))
> +        return transitions
> +
> +    def __parse_states(self):
> +        initial_state = ""
> +        states = []
> +        final_states = []
> +
> +        for node in self.__parse_tree.nodes:
> +            attr = self.__parse_tree.node_attrs[node]
> +            label = attr["label"]
> +
> +            if node.startswith(Automata.init_marker):
> +                initial_state = node[len(Automata.init_marker):]
> +
> +            if not label:
> +                continue
> +
> +            parser = StateLabelParser(attr["label"])
> +            state = State(parser.state, parser.constraint)
> +
> +            states.append(state)
> +
> +            shape = attr.get("shape")
> +            if shape in ("doublecircle", "ellipse"):
> +                final_states.append(state)
> +
> +
> +        initial_state = next((s for s in states if s.name == initial_state), None)
> +        if not initial_state:
> +            raise AutomataError("The automaton doesn't have an initial state")
> +
> +        if not final_states:
> +            final_states.append(initial_state)
> +
> +        states.remove(initial_state)
> +        states.sort(key=lambda s : s.name)
> +        states.insert(0, initial_state)
> +        return states, initial_state, final_states
> +
>      def __get_state_variables(self) -> tuple[list[str], str, list[str]]:
>          # wait for node declaration
>          states = []
> -- 
> 2.47.3
> 

