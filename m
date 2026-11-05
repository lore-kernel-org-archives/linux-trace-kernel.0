Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.38.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891073;
	b=Pd6Y2Xa/mHzC8XMMpGazXgKJ+C6yMfZgXSnNf/ObGizzJ4VBhAlBcyUvmIuGMPxf8OcG
	 iDCVsoxftIdMibOfzHhhxTsgIe/GBLc/waTtcIOYz6Sf7ZBX2GiUWuIPJiSQVL+dgQ06b
	 6pH+ZiRQIut5yQo3SlIHXPgLBj2q0lGoDhvdLRnOPfznxja8y5WWxJJCtuBIteTcAEhz4
	 btUHzbIWL6iVW8rX1nF62Ee2xMkoGMjJFYWILOCsrieDh2Awz4ONYcEZV1KfkxJhgCSv8
	 7bj6822PQTJhZrWcn+bQa5fk+G9NK8f5uvKyA6v92n4oeW24w7s6dELGoYsu4+CzJag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891073;
	h=DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-malware-bazaar;
	bh=5hdPZuerhWgKlWAPIqm6pL4yyIFyw2APmpiX9MIpxVM=;
	b=KCjmd7ElXctlYJqvWVjAUvWt4EU0Zse8iUt3X5VyZfAerhki0eZ5OGe67lFftgeum8fx
	 cBwVgOBbv1TtSVMcbDsmURrAL1da3dCDRJ+q8YP9vLReMhIfNgpNc0X71CK/R27fwUjGx
	 lrG+Wjt79ROeObQEOdZyKI9FtNNYjN2pkE7478CMZ+m5Z5aLcXg+N5CFCJpcaK7yp7T0N
	 vhMxG/5EJ7eP+FwCrjZH4CZ2hK7Vgf9mjiWex1P8wxGMRrmlBIQ4QH6CksNpG8TJ8viHo
	 s7pjX41vlFiNk3d+F6DmV3KmIXyNMp3PHSsuzNJPkrU/dcM28+1Or5JEAG1TX4kBZww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=sipsolutions.net;
	spf=pass smtp.mailfrom=sipsolutions.net;
	dkim=pass header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=e9j7ywGo;
	arc=none smtp.remote-ip=168.119.38.16
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E818E606A31B;
	Thu,  5 Nov 2026 15:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=e9j7ywGo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=5hdPZuerhWgKlWAPIqm6pL4yyIFyw2APmpiX9MIpxVM=;
	t=1793891072; x=1795100672; b=e9j7ywGoXsw2DPAC5YiiaZRaZXvqiFUwS4XSED/zRWqgS7b
	TUQFWGenjmITERDEgYOrX7q4t4uTUhN4h4s/5xz782/4YClQvGiDL06AtGKAPWrKKdM7bURFOnLFp
	t5viHWtdD3YrqTRCSowTWoCq+RUU+eGrkRGS5bW25hImbYo9nrKNQcMTbG/NjVNBfxmUWXKo4W354
	dm3BKc+4wprU7pWmKJyrcMbA9QXil0W5EE/22joP704VN9iIQk/ToxV6CsxJAijkbjJ2CEyPUUp57
	GamS+eJYO/K4w8uAqPr4rOPAuN9Bd/C2SjB7oNWTQGfmzlkl2wqQ9NjzN/jvqy7g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xOz0o-000000080jP-0X49;
	Thu, 05 Nov 2026 16:04:22 +0100
Message-ID: <8da2902c233de42ce756b3bfba5e5821f4dfa82b.camel@sipsolutions.net>
Subject: Re: [PATCH v7 0/4] tracing: improve symbolic printing
From: Johannes Berg <johannes@sipsolutions.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Ilya Maximets
 <i.maximets@ovn.org>, Matthieu Baerts	 <matttbe@kernel.org>, Aaron Conole
 <aconole@redhat.com>, Eelco Chaudron	 <echaudro@redhat.com>,
 dev@openvswitch.org, Adrian Moreno <amorenoz@redhat.com>,  Antoine Tenart
 <atenart@kernel.org>
Date: Thu, 05 Nov 2026 16:04:21 +0100
In-Reply-To: <20261105091216.7b91db5a@gandalf.local.home>
References: <20260922110955.363677-6-johannes@sipsolutions.net>
	 <20261105091216.7b91db5a@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2026-11-05 at 09:12 -0500, Steven Rostedt wrote:
> Could you also add code in the samples/trace_events directory. Perhaps ad=
d
> a new event?
>=20
> This will make it easier to understand exactly how to add new __print_sym=
()s.

I guess so. I was kinda hoping to simply convert all the others - it
clearly has advantages this way.

Any objection to simply converting the __print_symbolic() sample? It
would look something like this:


--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -297,6 +297,28 @@ TRACE_DEFINE_ENUM(TRACE_SAMPLE_FOO);
 TRACE_DEFINE_ENUM(TRACE_SAMPLE_BAR);
 TRACE_DEFINE_ENUM(TRACE_SAMPLE_ZOO);
=20
+/* define the names as { value, "name" } tuples for __print_sym() below */
+TRACE_DEFINE_SYM_LIST(sample_names,
+	{ 0, "zero" },
+	{ TRACE_SAMPLE_FOO, "TWO" },
+	{ TRACE_SAMPLE_BAR, "FOUR" },
+	{ TRACE_SAMPLE_ZOO, "EIGHT" },
+	{ 10, "TEN" }
+);
+
+/*
+ * Alternatively, you could define a function for the names:
+ *
+ * The _lookup() function returns the string for the given value.
+ *
+ * The _show() function must
+ *	seq_printf(m, ", { %u, \"%s\" }", value, name);
+ * for each value that userspace should be able to parse.
+ */
+const char *sample_names2_lookup(unsigned long long value);
+void sample_names2_show(struct seq_file *m);
+TRACE_DEFINE_SYM_FNS(sample_names2, sample_names2_lookup, sample_names2_sh=
ow);
+
 TRACE_EVENT(foo_bar,
=20
 	TP_PROTO(const char *foo, int bar, const int *lst,
@@ -340,14 +362,10 @@ TRACE_EVENT(foo_bar,
  *    the variable matches one of the values, then it will print the
  *    string in that pair. If non are matched, it returns a string
  *    version of the number (if __entry->bar =3D=3D 7 then "7" is returned=
).
+ *
+ *    See above for the declaration of "sample_names".
  */
-		  __print_symbolic(__entry->bar,
-				   { 0, "zero" },
-				   { TRACE_SAMPLE_FOO, "TWO" },
-				   { TRACE_SAMPLE_BAR, "FOUR" },
-				   { TRACE_SAMPLE_ZOO, "EIGHT" },
-				   { 10, "TEN" }
-			  ),
+		  __print_sym(__entry->bar, sample_names),
=20
 /*
  *  __print_flags( variable, "delim", { value, "flag" }, ... ),



It did show a bug because TRACE_SYSTEM isn't a C var in that file (and
perhaps only in that file?), so I'll have to resend with that fixed
anyway.


> FYI, this series did pass all my tests.

Cool. Sorry the earlier (long time ago) version had the __init_data
issue, I'd mostly tested on UML and that wasn't protected there.

johannes
