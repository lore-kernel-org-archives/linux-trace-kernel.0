Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CFF3254A2;
	Thu, 28 May 2026 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779956894; cv=none; b=eghHyChBvppH1RgddisJ42vKorerg7urp08HY4UgK0nmjJqSVq244xTS6/u735MV1PEyy8kSIj57ykqCfrqBEA4yR0A9F3U5422INRYPZ1CJEObBwiYIKRkBHgHE0xuLY1RSyus9gwxrYZdegnw9BLw0M6JJONyG+tpIEnwF4fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779956894; c=relaxed/simple;
	bh=4cDPxgkiUx8eA2XubeKOcrKhfafUsPKfDm/JX+QhJyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ui6FvpGw28t088LEEKAlalJl02RKUZnimxMHfykiehfoFt3Km4rIEKCpc8eFY7iR2XPAKky0r6PfC6WeOMzE1GCCd7bdmQLJvOLUvkX9Ci0AIeZ2J8LLSNFy7KhdwKzHebOy6X8VTXnAJw3wErhfwIUcTWnvhakcusIC3Rr5Gp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fyuP6YUc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WFhMu+T0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fyuP6YUc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WFhMu+T0"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779956891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZDkqmO5QVsaiUG+cmH8pQA2/DVSqeiCm9rHoyjU+5A=;
	b=fyuP6YUccOIpCE+/rY8sVkXfi0ZhI6WfMxmv2qIootDtiK9whya9RYMteigZfeMyjeOVXi
	pUDjyxf2qbCLUbMKstt7nREwf3rzF7vtALOEGnjK8D921HfFjjiYn5mflhk8vbrZq7V+iX
	IpkTmX/eyFWASGwI48qedJ9pbNQXsYFzWaX0yyRfBcE0hRjkNw9GS7ExaqgwjVlF0vPGC5
	g4LcNUC/tfwZEyuWOw6GlrkgTNKLi1aWK2RIOGG4UKK3SnEkZKE1tCiOh+6BvKrk9F5c2Z
	LbSlpyBIzvMMoADxA9AzpPOq2q9MqLFlJgPjz7f9M445TtHvNY3Zs+2CiecW/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779956891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZDkqmO5QVsaiUG+cmH8pQA2/DVSqeiCm9rHoyjU+5A=;
	b=WFhMu+T0aeD6WImctdnYvJRuccMYQ7wLoNytTKjwP9Y6iC/4OZ/XG/+VXVqDvPwTjLjxIN
	Mdmle42xaWrxwJCA==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 02/13] verification/rvgen: Introduce a parse tree for automata using Lark
Date: Thu, 28 May 2026 10:27:50 +0200
Message-ID: <13a2f241b74e02b13efa7fe188be3fa7e6148b4a.1779956342.git.namcao@linutronix.de>
In-Reply-To: <cover.1779956342.git.namcao@linutronix.de>
References: <cover.1779956342.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The DOT parsing scripts directly parse the raw text and they are quite
fragile. If the input dot files' formats are slightly changed (for
instance, by breaking long some lines which is allowed by the DOT language
defined by graphviz), the scripts would fail.

To make the scripts robust, the parser should be implemented based on the
dot language specification, not based on how the existing dot files look.

As a first step, use Lark to implement a Parser based on the graphviz dot
language specification. The resulting parse tree is not used yet, but the
existing scripts will be converted one by one to use this new parse tree in
the follow-up commits.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
v2:
  - switch to use Lark's CNAME for identifier [Wander]
  - switch to use Lark's ESCAPED_STRING for string [Sashiko]
  - clean up variable name shadowing [Sashiko]
  - Properly catch Lark exception
---
 tools/verification/rvgen/rvgen/automata.py | 186 +++++++++++++++++++++
 1 file changed, 186 insertions(+)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verificatio=
n/rvgen/rvgen/automata.py
index b9f8149f7118..8649d982383d 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -13,6 +13,191 @@ import re
 from typing import Iterator
 from itertools import islice
=20
+import lark
+
+class ParseTree:
+    # based on https://graphviz.org/doc/info/lang.html
+    # with the irrelevant stuffs (port and compass) removed
+    grammar =3D r'''
+    start: "strict"? ("graph" | "digraph") ID? "{" stmt_list "}"
+
+    stmt_list: (stmt ";"? stmt_list)?
+
+    stmt: node_stmt
+        | edge_stmt
+        | attr_stmt
+        | ID "=3D" ID
+        | subgraph
+
+    attr_stmt: attr_type attr_list
+
+    attr_type: "graph" -> graph
+            | "node"  -> node
+            | "edge"  -> edge
+
+    attr_list: "[" a_list? "]" attr_list?
+
+    a_list: ID "=3D" ID (";" | ",")? a_list?
+
+    edge_stmt: (node_id | subgraph) edgerhs attr_list?
+
+    edgerhs: edgeop (node_id | subgraph) edgerhs?
+
+    edgeop: "->" | "--"
+
+    node_stmt: node_id attr_list?
+
+    node_id: ID
+
+    subgraph: ("subgraph" ID?)? "{" stmt_list "}"
+
+    ID: CNAME
+      | /-?(\.[0-9]+|[0-9]+(\.[0-9]*))/
+      | ESCAPED_STRING
+
+    %import common.CNAME
+    %import common.ESCAPED_STRING
+    %import common.WS
+    %ignore WS
+    '''
+
+    @staticmethod
+    def parse_edge(tree: lark.Tree) -> tuple[str, str]:
+        # only support a simple node-to-node edge
+        nodes =3D []
+        for node in tree.iter_subtrees_topdown():
+            if node.data =3D=3D "node_id":
+                nodes.append(node.children[0].strip('"'))
+
+        if len(nodes) !=3D 2:
+            raise AutomataError("Only state-to-state transition is support=
ed")
+
+        return tuple(nodes)
+
+    class ParseNodes(lark.visitors.Visitor):
+        def __init__(self, *args, **kwargs):
+            self.nodes =3D set()
+            super().__init__(*args, **kwargs)
+
+        def node_stmt(self, tree):
+            node_id =3D tree.children[0]
+            node =3D node_id.children[0].strip('"')
+            self.nodes.add(node)
+
+    class ParseEdges(lark.visitors.Visitor):
+        def __init__(self, *args, **kwargs):
+            self.edges =3D set()
+            super().__init__(*args, **kwargs)
+
+        def edge_stmt(self, tree):
+            edge =3D ParseTree.parse_edge(tree)
+            self.edges.add(edge)
+
+    class ParseAttributes(lark.visitors.Interpreter):
+        def __init__(self, *args, **kwargs):
+            '''
+            Stacks of default attributes. [0] is the default
+            attributes for the outermost scope, while [-1] is the
+            default attributes for the current scope.
+            '''
+            self.default_node_attrs =3D [{}]
+            self.default_edge_attrs =3D [{}]
+
+            self.node_attrs =3D {}
+            self.edge_attrs =3D {}
+
+            super().__init__(*args, **kwargs)
+
+        @staticmethod
+        def __get_attrs(stmt: lark.Tree) -> dict[str, str]:
+            attrs =3D {}
+
+            for node in stmt.iter_subtrees():
+                if node.data =3D=3D "a_list":
+                    attrs[node.children[0]] =3D node.children[1].strip('"')
+
+            return attrs
+
+
+        def subgraph(self, tree):
+            # We are entering a new scope, inherit the default
+            # attributes of the outer scope
+            self.default_node_attrs.append(self.default_node_attrs[-1].cop=
y())
+            self.default_edge_attrs.append(self.default_edge_attrs[-1].cop=
y())
+
+            children =3D self.visit_children(tree)
+
+            # Exiting the scope
+            del self.default_node_attrs[-1]
+            del self.default_edge_attrs[-1]
+
+            return children
+
+        def node_stmt(self, tree):
+            node_id =3D tree.children[0]
+            node =3D node_id.children[0].strip('"')
+
+            attrs =3D self.default_node_attrs[-1].copy()
+            attrs |=3D self.__get_attrs(tree)
+
+            if attrs:
+                if node in self.node_attrs:
+                    self.node_attrs[node] =3D attrs | self.node_attrs[node]
+                else:
+                    self.node_attrs[node] =3D attrs
+
+            return self.visit_children(tree)
+
+        def edge_stmt(self, tree):
+            edge =3D ParseTree.parse_edge(tree)
+
+            attrs =3D self.default_edge_attrs[-1].copy()
+            attrs |=3D self.__get_attrs(tree)
+
+            if attrs:
+                if edge in self.edge_attrs:
+                    self.edge_attrs[edge] =3D attrs | self.edge_attrs[edge]
+                else:
+                    self.edge_attrs[edge] =3D attrs
+
+            return self.visit_children(tree)
+
+        def attr_stmt(self, tree):
+            attr_type =3D tree.children[0].data
+            attrs =3D self.__get_attrs(tree)
+
+            if attr_type =3D=3D "node":
+                self.default_node_attrs[-1] |=3D attrs
+            elif attr_type =3D=3D "edge":
+                self.default_edge_attrs[-1] |=3D attrs
+            else:
+                # graph attributes are irrelevant
+                pass
+
+            self.visit_children(tree)
+
+    def __init__(self, dot_file):
+        parser =3D lark.Lark(self.grammar, parser=3D'lalr')
+        node_parser =3D self.ParseNodes()
+        edge_parser =3D self.ParseEdges()
+        attributes_parser =3D self.ParseAttributes()
+
+        try:
+            with open(dot_file, "r") as f:
+                tree =3D parser.parse(f.read())
+                attributes_parser.visit(tree)
+                node_parser.visit(tree)
+                edge_parser.visit(tree)
+        except OSError as exc:
+            raise AutomataError(exc.strerror) from exc
+        except lark.exceptions.UnexpectedInput as exc:
+            raise AutomataError(str(exc))
+
+        self.nodes =3D node_parser.nodes
+        self.edges =3D edge_parser.edges
+        self.node_attrs =3D attributes_parser.node_attrs
+        self.edge_attrs =3D attributes_parser.edge_attrs
+
 class _ConstraintKey:
     """Base class for constraint keys."""
=20
@@ -66,6 +251,7 @@ class Automata:
         self.__dot_path =3D file_path
         self.name =3D model_name or self.__get_model_name()
         self.__dot_lines =3D self.__open_dot()
+        self.__parse_tree =3D ParseTree(file_path)
         self.states, self.initial_state, self.final_states =3D self.__get_=
state_variables()
         self.env_types =3D {}
         self.env_stored =3D set()
--=20
2.47.3

