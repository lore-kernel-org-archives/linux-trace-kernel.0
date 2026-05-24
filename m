Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB953A9DBA
	for <linux-trace-kernel@vger.kernel.org>; Sun, 24 May 2026 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779639875; cv=none; b=E/2I2Txsinh1T8Wby/2pBtYXMkNeTrS24Ockd3j543qoMz2eb9PipMgFo1m6iNsp/ASJ5VgCSS6nJar+0W4P5rOdTfUTTBsKwQY1CIz+YHu5bTPi9sIOaLnq5IEzZkeqChGZSvCGcpiRUoujtNfJsOP2vwLTTZ742GXH76jzMa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779639875; c=relaxed/simple;
	bh=YMLUdYJpSAv9W6a0MPnW8IT63V8WblIkM/oK3UeUH/g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZFRhemb/8i3NNQrlifU7R2rD2FByV54eXqmqbweWxxy3XrJzDVZXwzSJvItGxYO0BvCI3m4M9ElUw7JVW63Q9+d4E9RmENGeKF/RJzxLe+dGnQoaL4ZGpRd4CPLX8ABDct1RCp0KzVLuY24bpTt3qsqu5HJFKGK10UxwRyyBOE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=OjVEeiik; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="OjVEeiik"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=FPNgwzfKTdfYDJo5fIWKjQ4i2QnMSuYT/TxQN7r+oGQ=; b=OjVEeiikPeruOMExN7kU+XTnPc
	wFJRxvh5ASNcmBCQjLNigQuDiAOuDYnH4Vfg1rhWqG7PkQf1nPJWgjWOKASwYn7bmfHqjYL7IxN1B
	CiR9HxZPkn9Z0rRGMfMrSPh1+0Pl2/5yqBhcwBriXzTjQ9zZlbw6vLdztavi8etvGPWbi1E2ov66y
	M+9xBxd2QCFuK+pWG0UsdWYTSM808+XngbHUGK4MeGQo2bsZhDygMOPncPJ8CrF2PkLMej0UKNPrl
	B+N+e59DmeMKow8X1t0fRqbKtiqJbBOfBWdbW8AJjiQvlPDCFQvlqA43DlgKkUABcEdtUmNENfRJn
	HYMf32SQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wRBcn-000vXj-0W;
	Sun, 24 May 2026 16:24:25 +0000
Date: Sun, 24 May 2026 18:24:23 +0200
From: Ben Hutchings <benh@debian.org>
To: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Subject: [PATCH RESEND] rtla: Fix output files in source tree
Message-ID: <ahMmN4PdsJzr_Va-@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qflP0Qj7SIBB68vm"
Content-Disposition: inline
X-Debian-User: benh


--qflP0Qj7SIBB68vm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some output files (src/timerlat.bpf.o, src/timerlat.skel.h,
example/timerlat_bpf_action.o, tests/bpf/bpf_action_map.o) are
currently generated in the source tree, preventing a fully out-of-tree
build.  To fix this:

- Add $(OUTPUT) to their filenames in the relevant Makefile rules, and
  create subdirectories as needed
- Add $(OUTPUT)src to the include path
- Add ${OUTPUT} to the BPF object filename in tests/timerlat.t

Fixes: e34293ddcebd ("rtla/timerlat: Add BPF skeleton to collect samples")
Fixes: 0304a3b7ec9a ("rtla/timerlat: Add example for BPF action program")
Fixes: 5525aebd4e0c ("rtla/tests: Test BPF action program")
Signed-off-by: Ben Hutchings <benh@debian.org>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/tracing/rtla/Makefile         | 31 ++++++++++++++++++-----------
 tools/tracing/rtla/tests/timerlat.t |  4 ++--
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 45690ee14544..f54da7be735d 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -66,30 +66,37 @@ ifeq ($(config),1)
   include Makefile.config
 endif
=20
+INCLUDES	=3D -I$(OUTPUT)src
+
 CFLAGS		+=3D $(INCLUDES) $(LIB_INCLUDES)
=20
 export CFLAGS OUTPUT srctree
=20
 ifeq ($(BUILD_BPF_SKEL),1)
-src/timerlat.bpf.o: src/timerlat.bpf.c
+$(OUTPUT)src/timerlat.bpf.o: src/timerlat.bpf.c
+	mkdir -p $(@D)
 	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -c $(filter %.c,$^) -o $@
=20
-src/timerlat.skel.h: src/timerlat.bpf.o
+$(OUTPUT)src/timerlat.skel.h: $(OUTPUT)src/timerlat.bpf.o
+	mkdir -p $(@D)
 	$(QUIET_GENSKEL)$(SYSTEM_BPFTOOL) gen skeleton $< > $@
=20
-example/timerlat_bpf_action.o: example/timerlat_bpf_action.c
+$(OUTPUT)example/timerlat_bpf_action.o: example/timerlat_bpf_action.c
+	mkdir -p $(@D)
 	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -c $(filter %.c,$^) -o $@
=20
-tests/bpf/bpf_action_map.o: tests/bpf/bpf_action_map.c
+$(OUTPUT)tests/bpf/bpf_action_map.o: tests/bpf/bpf_action_map.c
+	mkdir -p $(@D)
 	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -c $(filter %.c,$^) -o $@
 else
-src/timerlat.skel.h:
-	$(Q)echo '/* BPF skeleton is disabled */' > src/timerlat.skel.h
+$(OUTPUT)src/timerlat.skel.h:
+	mkdir -p $(@D)
+	$(Q)echo '/* BPF skeleton is disabled */' > $@
=20
-example/timerlat_bpf_action.o: example/timerlat_bpf_action.c
+$(OUTPUT)example/timerlat_bpf_action.o: example/timerlat_bpf_action.c
 	$(Q)echo "BPF skeleton support is disabled, skipping example/timerlat_bpf=
_action.o"
=20
-tests/bpf/bpf_action_map.o: tests/bpf/bpf_action_map.c
+$(OUTPUT)tests/bpf/bpf_action_map.o: tests/bpf/bpf_action_map.c
 	$(Q)echo "BPF skeleton support is disabled, skipping tests/bpf/bpf_action=
_map.o"
 endif
=20
@@ -103,7 +110,7 @@ static: $(RTLA_IN)
 rtla.%: fixdep FORCE
 	make -f $(srctree)/tools/build/Makefile.build dir=3D. $@
=20
-$(RTLA_IN): fixdep FORCE src/timerlat.skel.h
+$(RTLA_IN): fixdep FORCE $(OUTPUT)src/timerlat.skel.h
 	make $(build)=3Drtla
=20
 clean: doc_clean fixdep-clean
@@ -111,10 +118,10 @@ clean: doc_clean fixdep-clean
 	$(Q)find . -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d=
' -delete
 	$(Q)rm -f rtla rtla-static fixdep FEATURE-DUMP rtla-*
 	$(Q)rm -rf feature
-	$(Q)rm -f src/timerlat.bpf.o src/timerlat.skel.h example/timerlat_bpf_act=
ion.o
+	$(Q)rm -f $(OUTPUT)src/timerlat.bpf.o $(OUTPUT)src/timerlat.skel.h $(OUTP=
UT)example/timerlat_bpf_action.o
 	$(Q)rm -f $(UNIT_TESTS)
=20
-check: $(RTLA) tests/bpf/bpf_action_map.o
+check: $(RTLA) $(OUTPUT)tests/bpf/bpf_action_map.o
 	RTLA=3D$(RTLA) BPFTOOL=3D$(SYSTEM_BPFTOOL) prove -o -f -v tests/
-examples: example/timerlat_bpf_action.o
+examples: $(OUTPUT)example/timerlat_bpf_action.o
 .PHONY: FORCE clean check
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests=
/timerlat.t
index fd4935fd7b49..e0f3fc4df655 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -74,12 +74,12 @@ then
 	# Test BPF action program properly in BPF mode
 	[ -z "$BPFTOOL" ] && BPFTOOL=3Dbpftool
 	check "hist with BPF action program (BPF mode)" \
-		"timerlat hist -T 2 --bpf-action tests/bpf/bpf_action_map.o --on-thresho=
ld shell,command=3D'$BPFTOOL map dump name rtla_test_map'" \
+		"timerlat hist -T 2 --bpf-action ${OUTPUT}tests/bpf/bpf_action_map.o --o=
n-threshold shell,command=3D'$BPFTOOL map dump name rtla_test_map'" \
 		2 '"value": 42'
 else
 	# Test BPF action program failure in non-BPF mode
 	check "hist with BPF action program (non-BPF mode)" \
-		"timerlat hist -T 2 --bpf-action tests/bpf/bpf_action_map.o" \
+		"timerlat hist -T 2 --bpf-action ${OUTPUT}tests/bpf/bpf_action_map.o" \
 		1 "BPF actions are not supported in tracefs-only mode"
 fi
 done

--qflP0Qj7SIBB68vm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoTJjIACgkQ57/I7JWG
EQm9lhAAi85FmzUEQ1PZM5ib1Eb9Gd+gTTQh3HIGH7b/lm4j9shvL8fgYybDDKZ2
dlHE0z+DtHjfcTPTPOkMLHQsllyMQIGRNSJSFWHPbdf26rKOV0oig/1P/sgnJDoD
6Oj8zlcTeQa8BnfE9vJltCv3f4qmbQAOTyLFDilZF07YgmD6/VAP46NuEKJ9OPPG
cpFZ7xLGiq2KP7EQNZubvzrB06F+tnNW+cZuRpbSmxWz4dBEFAjbD1GwegjYwyV/
k/d0GMFeGvervFKnKsmuA+319F4m7Ygv6e/JlDZRYFfh/8YbHM1s4Rz6HL+OZpw6
Tm37LWp51LoQbFehqNTI9xPgujMGm74ReoNulLlfguUhKuNuLTg6AasdQaBoIf6V
C6/gjntd/RfOfgKxCU0QRZGhkooasl7MGFKcfXiRf/5I8wPXHbHIUNUPEngsKRDI
vVOrTyEZzI5DloutTYtLImDd9WEtuIb+8F0qXBKa17yNNrZKRsP89R9rqICg1CwB
wPC8rpHfYAerQFbbS7kNj1uJFU0Qneu360XCxnvr7j53WzOG59e0HsKnpu+fvN1k
REfCDbWHv/zApnxWvjX6EA90m8LbbRXugTg6cNUjXbmY42BuYkfZnXiHKuVOJv33
S2dgmyGrtnd+jaP9h9FilN1VO4fgsXRLVSyP7JoQfxYfnwwF14I=
=lYq6
-----END PGP SIGNATURE-----

--qflP0Qj7SIBB68vm--
