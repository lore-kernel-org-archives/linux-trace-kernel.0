Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.38.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898549;
	b=pFIKNMajGe+9+yKhI+EhMZPAvxpYI4ut+vIXFf+1PDXMHuzQASFSU9HlvYH6cLqSStNA
	 DXLzKYYuRlWs4VBi0knpJ9tdb19JZ/ggmQhJeMye/c47/oM/S6qVGVc+oF3PDpudWDwgG
	 NLXksLtwter34CYjHXK+LcGbVmZGPSZ/RamEoGEAIDqWi0LCweOqidAGS0iyfXXxWGrUl
	 sgY5kQftonk5VXYxNdWcphYxLo6E1bfBxh7C+rycRfZv4u8EprkenHstmcEZh+UINRDrI
	 1fPu7K/M9M9EcawOx7CtnTeYjEmrzNshQT3x8jf8S2qdEy1FP56Q6d3/8Hk4CxW4tnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898549;
	h=DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-malware-bazaar;
	bh=9pcshHkbr1mkMc13IhC/TeO7WGUdu0MMea0JbyhMjVM=;
	b=zWJWTOs5rXce1HUUgB6J8/lPz920iPvf35tINp8HkU/PA2VvdX68dt0F6YCLLx7bAWJQ
	 WN5nfzEnarpolOCmPek77j0+TqqR6v761BWXOy3Zu6kG8rcCuCvGHMgs5s51IAzjTVw2x
	 noiaGxDlM6D/lc1TkJyggnW8iycDP+J0e+uOSkSu2VKNoPyMcelvRVZitCN/P0a1MJFVK
	 63LEtXpsAftXCRbrrkvNlesfVdc/pcW5JCurN2DJPmRxgXha0VdoCERvxEF+yf674oBp6
	 3yEv9gStJ0cXJA7ckeRHYYOxzEBO6YndeBTVBDX7EpWY0FfLToNBHpf0+u23tlTGNLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=sipsolutions.net;
	spf=pass smtp.mailfrom=sipsolutions.net;
	dkim=pass header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=JoJLrkcF;
	arc=none smtp.remote-ip=168.119.38.16
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A63606A326;
	Thu,  5 Nov 2026 17:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=JoJLrkcF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9pcshHkbr1mkMc13IhC/TeO7WGUdu0MMea0JbyhMjVM=;
	t=1793898547; x=1795108147; b=JoJLrkcFuse/iyva04KR4VR29KyHuQCtfkXvF5HFZ3CvqIJ
	XV8l2qRihc09po6OTywHz9SncdYIdtWAzE+NtfUp0vI3j0/kU4+YIhw1LjLaWg6AKCIcRDDhzpiXS
	L5iJoIQKnbeeOmy2SKNjMXv2uIXYOzTTt8PwBkwGEnwtE8+mp36PDKFbzwwrNTHrNwYV3vbA2Vtef
	4J+GONLshBK/Hv16o7agRqFISIEeDdSgvZp2OjoRi0kAgLkoOE1sQtAYUxpwM04v64zlqkwxgNgr9
	IB+tNGTUTTXM+6HdOUsx68aHJ97HSOk4R3wjzhfVuFKp2e7FY35roi8WKBoXp2VA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xP0xR-00000008Eu8-1vkG;
	Thu, 05 Nov 2026 18:09:01 +0100
Message-ID: <69c7cb8d0567f96dd03c2f35abb12b41ffa09f59.camel@sipsolutions.net>
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
Date: Thu, 05 Nov 2026 18:09:00 +0100
In-Reply-To: <20261105113857.4737cffb@gandalf.local.home>
References: <20260922110955.363677-6-johannes@sipsolutions.net>
		<20261105091216.7b91db5a@gandalf.local.home>
		<8da2902c233de42ce756b3bfba5e5821f4dfa82b.camel@sipsolutions.net>
		<20261105112444.7873d9c9@gandalf.local.home>
		<ba474cdb3bb30c3eaf4aafc6534d0e77cfde64d4.camel@sipsolutions.net>
	 <20261105113857.4737cffb@gandalf.local.home>
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

On Thu, 2026-11-05 at 11:38 -0500, Steven Rostedt wrote:
> On Thu, 05 Nov 2026 17:26:58 +0100
> Johannes Berg <johannes@sipsolutions.net> wrote:
>=20
> > On Thu, 2026-11-05 at 11:24 -0500, Steven Rostedt wrote:
> > > > Any objection to simply converting the __print_symbolic() sample? I=
t
> > > > would look something like this: =20
> > >=20
> > > Actually, keeping them both would be very useful. That way one can se=
e how
> > > to do it the other way. We can say, the old way is being deprecated s=
o
> > > please use the new way. =20
> >=20
> > What's the point? But OK, sure.
>=20
> I thought I mentioned the point? "That way one can see how to do it the
> other way". Basically, seeing the equivalent way.

You did say that, but I guess I don't really understand it - I see the
point of the sample as the status quo ("how to do it"), not the
evolutionary history ("how to convert it").

But sure, whatever you say, I don't really care.

> > > > +const char *sample_names2_lookup(unsigned long long value);
> > > > +void sample_names2_show(struct seq_file *m); =20
> > >=20
> > > Are the above going to be defined somewhere? =20
> >=20
> > Well, it's a sample, and I wasn't even using "sample_names2" in the
> > below, so I didn't actually define it. I can flesh that out even more,
> > but I'm not sure it's worth it?
>=20
> It is, otherwise it is confusing. If it is in the sample code, people wil=
l
> think it's required.

All of the sample code is optional though, you don't have to use any one
of the methods, either this, or enum, or ... if you want to use the
dynamic way of __print_sym() then it indeed is required.

Anyway I'll flesh this out more.

> Right, but if we want to deprecate the old way, we need to have the
> simplest sample of it. That is, have one event that shows the simple way =
to
> do this (one that simply replaces the old way), and then have another
> example of how to do it in a more complex and featureful way.
>=20
> Honestly, this is why I asked for this. Your updates use the complex
> method, I wasn't sure from the code how to do it for the simple case. Tha=
t
> is, what wasn't needed for just replacing static __print_symbolic() lists=
.

The simple way changes from

	__print_symbolic(foo, BRACED_LIST)

to

TRACE_DEFINE_SYM_LIST(foo_names, BRACED_LIST);
...
	__print_sym(foo, foo_names)


so I'm not sure I see how it's really that much more complex?


Anyway, how about below sample update?

johannes



--- a/samples/trace_events/trace-events-sample.c
+++ b/samples/trace_events/trace-events-sample.c
@@ -11,6 +11,36 @@
 #define CREATE_TRACE_POINTS
 #include "trace-events-sample.h"
=20
+/* functions for the dynamic __print_sym() example */
+static const struct {
+	unsigned long val;
+	char *name;
+} print_sym_dynamic_names[] =3D {
+	{ 0, "zero" },
+	{ TRACE_SAMPLE_FOO, "TWO" },
+	{ TRACE_SAMPLE_BAR, "FOUR" },
+	{ TRACE_SAMPLE_ZOO, "EIGHT" },
+	{ 10, "TEN" }
+};
+
+const char *sample_names_dynamic_lookup(unsigned long long value)
+{
+	for (int i =3D 0; i < ARRAY_SIZE(print_sym_dynamic_names); i++) {
+		if (print_sym_dynamic_names[i].val =3D=3D value)
+			return print_sym_dynamic_names[i].name;
+	}
+
+	return NULL;
+}
+
+void sample_names_dynamic_show(struct seq_file *m)
+{
+	for (int i =3D 0; i < ARRAY_SIZE(print_sym_dynamic_names); i++)
+		seq_printf(m, ", { %lu, \"%s\" }",
+			   print_sym_dynamic_names[i].val,
+			   print_sym_dynamic_names[i].name);
+}
+
 static const char *random_strings[] =3D {
 	"Mother Goose",
 	"Snoopy",
diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_eve=
nts/trace-events-sample.h
index 816848a456a2..38d6bf808de6 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -297,6 +297,33 @@ TRACE_DEFINE_ENUM(TRACE_SAMPLE_FOO);
 TRACE_DEFINE_ENUM(TRACE_SAMPLE_BAR);
 TRACE_DEFINE_ENUM(TRACE_SAMPLE_ZOO);
=20
+/*
+ * define the names as { value, "name" } tuples for __print_sym() below,
+ * same as the inline list for __print_dynamic()
+ */
+TRACE_DEFINE_SYM_LIST(sample_names_static,
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
+const char *sample_names_dynamic_lookup(unsigned long long value);
+void sample_names_dynamic_show(struct seq_file *m);
+TRACE_DEFINE_SYM_FNS(sample_names_dynamic,
+		     sample_names_dynamic_lookup,
+		     sample_names_dynamic_show);
+
 TRACE_EVENT(foo_bar,
=20
 	TP_PROTO(const char *foo, int bar, const int *lst,
@@ -328,7 +355,7 @@ TRACE_EVENT(foo_bar,
 		__assign_cpumask(cpum, cpumask_bits(mask));
 	),
=20
-	TP_printk("foo %s %d %s %s %s %s %s %s (%s) (%s) %s [%d] %*pbl",
+	TP_printk("foo %s %d %s %s %s %s %s %s %s %s (%s) (%s) %s [%d] %*pbl",
 		  __entry->foo, __entry->bar,
=20
 /*
@@ -340,6 +367,9 @@ TRACE_EVENT(foo_bar,
  *    the variable matches one of the values, then it will print the
  *    string in that pair. If non are matched, it returns a string
  *    version of the number (if __entry->bar =3D=3D 7 then "7" is returned=
).
+ *
+ * NOTE: This variant is deprecated, it uses more space than the below
+ *	 __print_sym() which is identical to this for userspace.
  */
 		  __print_symbolic(__entry->bar,
 				   { 0, "zero" },
@@ -349,6 +379,21 @@ TRACE_EVENT(foo_bar,
 				   { 10, "TEN" }
 			  ),
=20
+/*
+ *  __print_sym( variable, symbol_list_definition ),
+ *
+ *    The variable is tested against each value of the symbol list.
+ *    The symbol list can be built statically (sample_names_static) or
+ *    dynamically (sample_names_dynamic). If the variable matches one
+ *    of the values, then it will print the string in that pair. If
+ *    no entry matches, the number itself is printed (e.g. here if
+ *    if __entry->bar =3D=3D 7 then "7" is shown).
+ *
+ *    See above for the declaration of sample_names_{static,dynamic}.
+ */
+		  __print_sym(__entry->bar, sample_names_static),
+		  __print_sym(__entry->bar, sample_names_dynamic),
+
 /*
  *  __print_flags( variable, "delim", { value, "flag" }, ... ),
  *
