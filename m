Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532EE171B1
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 18:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778870267; cv=none; b=KW84aKOe0qmC0wGlJLiajuOix8HfYfQciI14khSHRUsJYpJsvalCvbLfZxuDMkI2xmfoc2yt2rmhbmCyK4bTpkMdj4Ypa1JU5oTLLjwDaqD9TvSr9OR0DvLDH3E4IgWDKgQN8QPGBIBHiNKbzgTNPpFZq7uTUOCn4ApTPwhAwJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778870267; c=relaxed/simple;
	bh=9k73lsYTkKfHenyMz5o1ozjbSB5R0UZnvEMCZbtimVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DRkHxEubwtu8KvUqErY+CSOJHDfx8tdj+dFm1ZScbMsPiOnO69UbWSVC8fFAfi3rNyivRokqPTvDtBhkQfFAO8Y94BI1Z9Vfx5Fu4cYkP55iT2RrBQPIzlDkcsOQPaIRsF3+aBhGJ9GzNE0DFjVi80JnUWu1bNamyIMwZmhR7Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YDvHwMr2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDvHwMr2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778870253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K+3HW5TSdCFq/3iTaWrlGQtcelhbrNMdj3iL9pWy9D4=;
	b=YDvHwMr2bptTWP7mRk4vW9pvzDzrReCjmoZ+wgyJ17w3GCzrDo0ZESsnMNa+8Fmz1i6Rjz
	tK7uBsI6KQoOvilJkNJjoOneX78BEJuVHE9ilt+8V30aCt6+bq7G6ftVJXRXjxPNEeHsj/
	86vaJGhbCwd9E44cFPeohfefjH2bS1U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-JzJutLICPUuVOWBZNd2UAQ-1; Fri,
 15 May 2026 14:37:31 -0400
X-MC-Unique: JzJutLICPUuVOWBZNd2UAQ-1
X-Mimecast-MFC-AGG-ID: JzJutLICPUuVOWBZNd2UAQ_1778870250
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 801201800359;
	Fri, 15 May 2026 18:37:30 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.80.107])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2FE0219560A2;
	Fri, 15 May 2026 18:37:26 +0000 (UTC)
Date: Fri, 15 May 2026 15:37:25 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] verification/rvgen: Introduce a parse tree for
 automata using Lark
Message-ID: <agdnvQPLLiLBIxw7@wcosta-defaultstring.rmtbr.csb>
References: <cover.1777962130.git.namcao@linutronix.de>
 <050ac3d7aeb1ece12a4deb91fc173de24ad147de.1777962130.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <050ac3d7aeb1ece12a4deb91fc173de24ad147de.1777962130.git.namcao@linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: iOiv1w-y6ZewV2_LEh8jmZkSdvuOcqCIBX4RZdHhXz4_1778870250
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 05, 2026 at 08:59:23AM +0200, Nam Cao wrote:
> The DOT parsing scripts directly parse the raw text and they are quite
> fragile. If the input dot files' formats are slightly changed (for
> instance, by breaking long some lines which is allowed by the DOT language
> defined by graphviz), the scripts would fail.
> 
> To make the scripts robust, the parser should be implemented based on the
> dot language specification, not based on how the existing dot files look.
> 
> As a first step, use Lark to implement a Parser based on the graphviz dot
> language specification. The resulting parse tree is not used yet, but the
> existing scripts will be converted one by one to use this new parse tree in
> the follow-up commits.
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  tools/verification/rvgen/rvgen/automata.py | 182 +++++++++++++++++++++
>  1 file changed, 182 insertions(+)
> 
> diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
> index b9f8149f7118..4e3d719a0952 100644
> --- a/tools/verification/rvgen/rvgen/automata.py
> +++ b/tools/verification/rvgen/rvgen/automata.py
> @@ -13,6 +13,187 @@ import re
>  from typing import Iterator
>  from itertools import islice
>  
> +import lark
> +
> +class ParseTree:
> +    # based on https://graphviz.org/doc/info/lang.html
> +    # with the irrelevant stuffs (port and compass) removed
> +    grammar = r'''
> +    start: "strict"? ("graph" | "digraph") ID? "{" stmt_list "}"
> +
> +    stmt_list: (stmt ";"? stmt_list)?
> +
> +    stmt: node_stmt
> +        | edge_stmt
> +        | attr_stmt
> +        | ID "=" ID
> +        | subgraph
> +
> +    attr_stmt: attr_type attr_list
> +
> +    attr_type: "graph" -> graph
> +            | "node"  -> node
> +            | "edge"  -> edge
> +
> +    attr_list: "[" a_list? "]" attr_list?
> +
> +    a_list: ID "=" ID (";" | ",")? a_list?
> +
> +    edge_stmt: (node_id | subgraph) edgerhs attr_list?
> +
> +    edgerhs: edgeop (node_id | subgraph) edgerhs?
> +
> +    edgeop: "->" | "--"
> +
> +    node_stmt: node_id attr_list?
> +
> +    node_id: ID
> +
> +    subgraph: ("subgraph" ID?)? "{" stmt_list "}"
> +
> +    ID: /[_a-zA-Z][_a-zA-Z0-9]+/

This regex rejects symbol character symbol. Is that intentional?

> +      | /-?(\.[0-9]+|[0-9]+(\.[0-9]*))/
> +      | /".*?"/
> +
> +    %import common.WS
> +    %ignore WS
> +    '''
> +
> +    @staticmethod
> +    def parse_edge(tree: lark.Tree) -> tuple[str, str]:
> +        # only support a simple node-to-node edge
> +        nodes = []
> +        for node in tree.iter_subtrees_topdown():
> +            if node.data == "node_id":
> +                nodes.append(node.children[0].strip('"'))
> +
> +        if len(nodes) != 2:
> +            raise AutomataError("Only state-to-state transition is supported")
> +
> +        return tuple(nodes)
> +
> +    class ParseNodes(lark.visitors.Visitor):
> +        def __init__(self, *args, **kwargs):
> +            self.nodes = set()
> +            super().__init__(*args, **kwargs)
> +
> +        def node_stmt(self, tree):
> +            node_id = tree.children[0]
> +            node = node_id.children[0].strip('"')
> +            self.nodes.add(node)
> +
> +    class ParseEdges(lark.visitors.Visitor):
> +        def __init__(self, *args, **kwargs):
> +            self.edges = set()
> +            super().__init__(*args, **kwargs)
> +
> +        def edge_stmt(self, tree):
> +            edge = ParseTree.parse_edge(tree)
> +            self.edges.add(edge)
> +
> +    class ParseAttributes(lark.visitors.Interpreter):
> +        def __init__(self, *args, **kwargs):
> +            '''
> +            Stacks of default attributes. [0] is the default
> +            attributes for the outermost scope, while [-1] is the
> +            default attributes for the current scope.
> +            '''
> +            self.default_node_attrs = [{}]
> +            self.default_edge_attrs = [{}]
> +
> +            self.node_attrs = {}
> +            self.edge_attrs = {}
> +
> +            super().__init__(*args, **kwargs)
> +
> +        @staticmethod
> +        def __get_attrs(stmt: lark.Tree) -> dict[str, str]:
> +            attrs = {}
> +
> +            for node in stmt.iter_subtrees():
> +                if node.data == "a_list":
> +                    attrs[node.children[0]] = node.children[1].strip('"')
> +
> +            return attrs
> +
> +
> +        def subgraph(self, tree):
> +            # We are entering a new scope, inherit the default
> +            # attributes of the outer scope
> +            self.default_node_attrs.append(self.default_node_attrs[-1].copy())
> +            self.default_edge_attrs.append(self.default_edge_attrs[-1].copy())
> +
> +            children = self.visit_children(tree)
> +
> +            # Exiting the scope
> +            del self.default_node_attrs[-1]
> +            del self.default_edge_attrs[-1]
> +
> +            return children
> +
> +        def node_stmt(self, tree):
> +            node_id = tree.children[0]
> +            node = node_id.children[0].strip('"')
> +
> +            attrs = self.default_node_attrs[-1].copy()
> +            attrs |= self.__get_attrs(tree)
> +
> +            if attrs:
> +                if node in self.node_attrs:
> +                    self.node_attrs[node] = attrs | self.node_attrs[node]
> +                else:
> +                    self.node_attrs[node] = attrs
> +
> +            return self.visit_children(tree)
> +
> +        def edge_stmt(self, tree):
> +            edge = ParseTree.parse_edge(tree)
> +
> +            attrs = self.default_edge_attrs[-1].copy()
> +            attrs |= self.__get_attrs(tree)
> +
> +            if attrs:
> +                if edge in self.edge_attrs:
> +                    self.edge_attrs[edge] = attrs | self.edge_attrs[edge]
> +                else:
> +                    self.edge_attrs[edge] = attrs
> +
> +            return self.visit_children(tree)
> +
> +        def attr_stmt(self, tree):
> +            attr_type = tree.children[0].data
> +            attrs = self.__get_attrs(tree)
> +
> +            if attr_type == "node":
> +                self.default_node_attrs[-1] |= attrs
> +            elif attr_type == "edge":
> +                self.default_edge_attrs[-1] |= attrs
> +            else:
> +                # graph attributes are irrelevant
> +                pass
> +
> +            self.visit_children(tree)
> +
> +    def __init__(self, dot_file):
> +        parser = lark.Lark(self.grammar, parser='lalr')
> +        node_parser = self.ParseNodes()
> +        edge_parser = self.ParseEdges()
> +        attributes_parser = self.ParseAttributes()
> +
> +        try:
> +            with open(dot_file, "r") as dot_file:
> +                tree = parser.parse(dot_file.read())
> +                attributes_parser.visit(tree)
> +                node_parser.visit(tree)
> +                edge_parser.visit(tree)
> +        except OSError as exc:
> +            raise AutomataError(exc.strerror) from exc
> +
> +        self.nodes = node_parser.nodes
> +        self.edges = edge_parser.edges
> +        self.node_attrs = attributes_parser.node_attrs
> +        self.edge_attrs = attributes_parser.edge_attrs
> +
>  class _ConstraintKey:
>      """Base class for constraint keys."""
>  
> @@ -66,6 +247,7 @@ class Automata:
>          self.__dot_path = file_path
>          self.name = model_name or self.__get_model_name()
>          self.__dot_lines = self.__open_dot()
> +        self.__parse_tree = ParseTree(file_path)
>          self.states, self.initial_state, self.final_states = self.__get_state_variables()
>          self.env_types = {}
>          self.env_stored = set()
> -- 
> 2.47.3
> 

