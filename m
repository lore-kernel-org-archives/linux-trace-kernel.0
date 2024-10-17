Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0559192586
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Oct 2024 06:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729147448; cv=none; b=WNbxZr4Fsfc9ujoX/kOltyGRjwvqr5qLx3KogPM8XY5Fw/aKbYdvJPk8i8HOnHBIZTg6pwAqCj7P8q+0jxDLXsRkFbcnsCgBS5tuc1W8lvzxkhfjskncnxaPbdNzN7zKr6QF1R97XaCEXN242pq0jogqYwsTvKI80MmUMaUs218=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729147448; c=relaxed/simple;
	bh=zZRhs+LJM8PYiIfb9B/c5FEarnXqQ/S1NWxt2ut+LAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvwNJuS0tYsngV3L7cPYhp01buYvbV4t8vJr/E/BtIRvWlIkgFdvVzbyin8m90XuNBYZJtIaQ7rgORhcOKenZ5yCmQUSvOX5d4kbulHcc0ksEI7iJFoZT+a/PJf4uLJ9s84MsogIFrFUCtaKX+L+vyERBUy0JzFCW8r18ky+aGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CskP/1lY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CskP/1lY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729147444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PmnUx6fZIjucgBmJqe8ji0b+nkj5ikpuINwXC7B1aVY=;
	b=CskP/1lYQ5euMdCakz2oUmkUhI816dPQhIpjJvH7vnmnX8+Ptdyv6Z6seI/W4E1DW12UAe
	j8pYV/MZVySzxWGZrFGmEOUIz/PxQUz2AXp9mTGHSjhPGPHdjystPePQ36Q9/Rlnbxi1kJ
	/QacI2RARlljVnbbNq2qSdocVV73g1E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-lPonciA1MjOMKbGPWDvwpA-1; Thu,
 17 Oct 2024 02:44:00 -0400
X-MC-Unique: lPonciA1MjOMKbGPWDvwpA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E1BB1955E9F;
	Thu, 17 Oct 2024 06:43:59 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.60.16.91])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 13CED19560A2;
	Thu, 17 Oct 2024 06:43:57 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v2] verification/dot2: Improve dot parser robustness
Date: Thu, 17 Oct 2024 08:42:39 +0200
Message-ID: <20241017064238.41394-2-gmonaco@redhat.com>
In-Reply-To: <20241016135812.59296-1-gmonaco@redhat.com>
References: <20241016135812.59296-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This patch makes the dot parser used by dot2c and dot2k slightly more
robust, namely:
* allows parsing files with the gv extension (GraphViz)
* correctly parses edges with any indentation
    * used to work only with a single character (e.g. '\t')
Additionally it fixes a couple of warnings reported by pylint such as
wrong indentation and comparison to False instead of `not ...`

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
V1 -> V2: properly handling shorter gv extension with ntpath.splitext

 tools/verification/dot2/automata.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/verification/dot2/automata.py b/tools/verification/dot2/automata.py
index baffeb960ff0..bdeb98baa8b0 100644
--- a/tools/verification/dot2/automata.py
+++ b/tools/verification/dot2/automata.py
@@ -29,11 +29,11 @@ class Automata:
 
     def __get_model_name(self):
         basename = ntpath.basename(self.__dot_path)
-        if basename.endswith(".dot") == False:
+        if not basename.endswith(".dot") and not basename.endswith(".gv"):
             print("not a dot file")
             raise Exception("not a dot file: %s" % self.__dot_path)
 
-        model_name = basename[0:-4]
+        model_name = ntpath.splitext(basename)[0]
         if model_name.__len__() == 0:
             raise Exception("not a dot file: %s" % self.__dot_path)
 
@@ -68,9 +68,9 @@ class Automata:
     def __get_cursor_begin_events(self):
         cursor = 0
         while self.__dot_lines[cursor].split()[0] != "{node":
-           cursor += 1
+            cursor += 1
         while self.__dot_lines[cursor].split()[0] == "{node":
-           cursor += 1
+            cursor += 1
         # skip initial state transition
         cursor += 1
         return cursor
@@ -94,11 +94,11 @@ class Automata:
                 initial_state = state[7:]
             else:
                 states.append(state)
-                if self.__dot_lines[cursor].__contains__("doublecircle") == True:
+                if "doublecircle" in self.__dot_lines[cursor]:
                     final_states.append(state)
                     has_final_states = True
 
-                if self.__dot_lines[cursor].__contains__("ellipse") == True:
+                if "ellipse" in self.__dot_lines[cursor]:
                     final_states.append(state)
                     has_final_states = True
 
@@ -110,7 +110,7 @@ class Automata:
         # Insert the initial state at the bein og the states
         states.insert(0, initial_state)
 
-        if has_final_states == False:
+        if not has_final_states:
             final_states.append(initial_state)
 
         return states, initial_state, final_states
@@ -120,7 +120,7 @@ class Automata:
         cursor = self.__get_cursor_begin_events()
 
         events = []
-        while self.__dot_lines[cursor][1] == '"':
+        while self.__dot_lines[cursor].lstrip()[0] == '"':
             # transitions have the format:
             # "all_fired" -> "both_fired" [ label = "disable_irq" ];
             #  ------------ event is here ------------^^^^^
@@ -161,7 +161,7 @@ class Automata:
         # and we are back! Let's fill the matrix
         cursor = self.__get_cursor_begin_events()
 
-        while self.__dot_lines[cursor][1] == '"':
+        while self.__dot_lines[cursor].lstrip()[0] == '"':
             if self.__dot_lines[cursor].split()[1] == "->":
                 line = self.__dot_lines[cursor].split()
                 origin_state = line[0].replace('"','').replace(',','_')

base-commit: 2f87d0916ce0d2925cedbc9e8f5d6291ba2ac7b2
-- 
2.47.0

