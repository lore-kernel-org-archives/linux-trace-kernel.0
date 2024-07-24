Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976844D8B9
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jul 2024 18:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721846549; cv=none; b=UYriHCsNszXmQ8f3HY7Yj6Afhg1UgNno3SlHzJd4MAhrmvKntjdNyst6X6150UrdGkK8Aoe6L23JWWQSSHkcjyEvbwnyZpr4fzInl+jy0qNS9HQ8Uuo1b5uYlNErR7/7NZ348ABrsmjLqPle+9RP1QKTNqlL7liWkLLVhKvHZP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721846549; c=relaxed/simple;
	bh=RGMuvHJD5IuJiqh+nQhvvXUQqjzzrT8quoKs8CDBGrk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=CUAJ2P4ubEbxDuN15zMCUiFdVJtJ3NnYadm900p3ofgNxBj1xKeGHRQow1zxEAlKULObesYTFCVYlhBCQCqsWRPG9tVVbgsPzX4S3PuPsWtUTDyQtZpdvHPU/rRuBoeVvZceMYbVWbIsiyToPZ873kYskqxC5aDqMgCw5jPhurM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16E0C32781;
	Wed, 24 Jul 2024 18:42:28 +0000 (UTC)
Date: Wed, 24 Jul 2024 14:42:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH] trace-cmd: Add meson build targets to Makefile
Message-ID: <20240724144247.783134b5@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Add make targets for building with meson:

  make meson
  make meson_install
  make meson_docs

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Makefile       | 14 +++++++++++++-
 Makefile.meson | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 1 deletion(-)
 create mode 100644 Makefile.meson

diff --git a/Makefile b/Makefile
index 6a30eaf0a330..897c972ff9b7 100644
--- a/Makefile
+++ b/Makefile
@@ -527,7 +527,7 @@ install_doc:
 check_doc: force
 	$(Q)$(src)/check-manpages.sh $(src)/Documentation/libtracecmd
 
-clean:
+clean: clean_meson
 	$(RM) *.o *~ *.a *.so .*.d
 	$(RM) tags TAGS cscope* $(PKG_CONFIG_SOURCE_FILE) $(VERSION_FILE)
 	$(MAKE) -C $(src)/lib/trace-cmd clean
@@ -598,6 +598,18 @@ ctracecmd.so: force $(LIBTRACECMD_STATIC)
 PHONY += python
 python: $(PYTHON)
 
+meson:
+	$(MAKE) -f Makefile.meson
+
+meson_install:
+	$(MAKE) -f Makefile.meson install
+
+meson_docs:
+	$(MAKE) -f Makefile.meson docs
+
+PHONY += clean_meson
+clean_meson:
+	$(Q)$(MAKE) -f Makefile.meson $@
 
 dist:
 	git archive --format=tar --prefix=trace-cmd-$(TRACECMD_VERSION)/ HEAD \
diff --git a/Makefile.meson b/Makefile.meson
new file mode 100644
index 000000000000..71d6bf36c654
--- /dev/null
+++ b/Makefile.meson
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: GPL-2.0
+
+undefine CFLAGS
+
+# Makefiles suck: This macro sets a default value of $(2) for the
+# variable named by $(1), unless the variable has been set by
+# environment or command line. This is necessary for CC and AR
+# because make sets default values, so the simpler ?= approach
+# won't work as expected.
+define allow-override
+  $(if $(or $(findstring environment,$(origin $(1))),\
+            $(findstring command line,$(origin $(1)))),,\
+    $(eval $(1) = $(2)))
+endef
+
+$(call allow-override,MESON,meson)
+$(call allow-override,MESON_BUILD_DIR,build)
+
+
+all: compile
+
+PHONY += compile
+compile: $(MESON_BUILD_DIR) force
+	$(MESON) compile -C $(MESON_BUILD_DIR)
+
+$(MESON_BUILD_DIR):
+	$(MESON) setup --prefix=$(prefix) $(MESON_BUILD_DIR)
+
+install: compile
+	$(MESON) install -C $(MESON_BUILD_DIR)
+
+docs: $(MESON_BUILD_DIR)
+	$(MESON) compile -C build docs
+
+PHONY += clean_meson
+clean_meson:
+	$(Q)$(RM) -rf $(MESON_BUILD_DIR)
+
+PHONY += force
+force:
-- 
2.43.0

