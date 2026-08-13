Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A711F1A6838
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 23:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786662529; cv=none; b=agn089fYuKF/2piFY9V4zSmz1HXx3rUtvyqoUuvbjAr3vZV2nPvYnUU/lyp+m/oVgWlhqkxQbinjEELQZQpaJ74r1TkPEAu7fEmoEeh7uQFy+t9ipeuwzI8Ms+/B4KdLSmq9lwRhQkM2QvYTY4UX6tzT8YJe2HZM18Nj8q1D0n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786662529; c=relaxed/simple;
	bh=ALDLsnd09g7pUorbi6A/dK3lR3n4ukcOFgslpMdAwdc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HPBrKBEGOXEUeE7GXA1OClE8mWGgZ8pSTUz8YkYDGZR0HxhR+TCswsWN+MAiizK3nCmGTdgZTwZ9JQPxmMVTr72AbsYqzskODganCkZcCkGmrTArry2PB2FH50eGp2zVv4m8LbN3eDYnDoS9RE6aOk2XfCQ75FITWzU2xVYqiVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtA79DaH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtA79DaH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364281F000E9;
	Thu, 13 Aug 2026 23:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786662527;
	bh=RprnOdh71P9lHpjrDv5oEf8/yKEN0fxOL+o7ehqlXig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VtA79DaHBLnsptMc5lf00lMuo3x0g6IRja7ZneFqAOWAcwd/jPKwL5gIF9yyFGUrl
	 1mHRkoZYX3QUhO8i/ynA00AhQAHFerzbEEgB0ETEIUoTnrsJJJID94olb9zM+kofIS
	 ZNg7KSRUEM+/Fr8voSPfWwQYwEiedJ3/lXVDTlmH3dK6K0tpXpD8XPPEEhcyeK82Cy
	 XymHFeBKFI+2CahgDLfXzuQaMJgUE0a/VQKsFYMwm3S5VbYqfw2YSdGqWRDKkY8Ocj
	 //nwicfkKEv9keB9uI8lZ+Ou9ooFmTj/n4LFcMQ0MTVujox9+eD2TVBiZSMTa7t2KS
	 j60hqUJ4x08SQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 04/12] verification/rvgen: Add support for Hybrid
 Automata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gabriele Monaco" <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260330111010.153663-5-gmonaco@redhat.com>
References: <20260330111010.153663-5-gmonaco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 23:08:43 +0000
Message-Id: <20260813230847.364281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Spurious invalidity checks generated due to naive substring matchi=
ng.
- [High] State-specific self-loop resets are applied globally, causing impr=
oper invariant timer restarts.
- [High] Incorrect tracepoint class returned by `fill_monitor_class`, leadi=
ng to compilation failures.
- [Medium] Premature truncation of BFS algorithm in `__find_inv_conflicts`.
- [Medium] Regex `constraint_rule` fails to parse valid single-character va=
riables and identifiers containing digits.
- [Medium] Multiple state invariants separated by logical operators are sil=
ently truncated.
- [Medium] Substring matching for clock resets in `__find_inv_conflicts` yi=
elds false positives.
--

--- Patch [4]: [PATCH v8 04/12] verification/rvgen: Add support for Hybrid =
Automata ---
commit 12c92be15261e4701023aceb7f2bd71c606ecce3
Author: Gabriele Monaco <gmonaco@redhat.com>

verification/rvgen: Add support for Hybrid Automata

Add the possibility to parse dot files as hybrid automata and generate
the necessary code from rvgen.

> diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verificat=
ion/rvgen/rvgen/automata.py
> --- a/tools/verification/rvgen/rvgen/automata.py
> +++ b/tools/verification/rvgen/rvgen/automata.py

[ ... ]

> +    # val can be numerical, uppercase (constant or macro), lowercase (pa=
rameter or function)
> +    # only numerical values should have units
> +    constraint_rule =3D re.compile(r"""
> +        ^
> +        (?P<env>[a-zA-Z_][a-zA-Z0-9_]+)  # C-like identifier for the env=
 var
> +        (?P<op>[!<=3D>]{1,2})              # operator
> +        (?P<val>
> +            [0-9]+ |                     # numerical value
> +            [A-Z_]+\(\) |                # macro
> +            [A-Z_]+ |                    # constant
> +            [a-z_]+\(\) |                # function
> +            [a-z_]+                      # parameter
> +        )
> +        (?P<unit>[a-z]{1,2})?            # optional unit for numerical v=
alues
> +        """, re.VERBOSE)

[Severity: Medium]
Could this regular expression reject valid single-character variables?

The pattern requires environment variables to be at least two characters
long, which rejects single-letter variables like 'x' or 't'.

Additionally, does the value matching group (?P<val> ...) correctly
handle digits in constant, macro, function, or parameter names? The
current character sets [a-z_]+ and [A-Z_]+ appear to exclude numbers.

[ ... ]

> @@ -157,6 +260,7 @@ class Automata:
> =20
>          # declare the matrix....
>          matrix =3D [[ self.invalid_state_str for x in range(nr_event)] f=
or y in range(nr_state)]
> +        constraints: dict[_ConstraintKey, list[str]] =3D {}
> =20
>          # and we are back! Let's fill the matrix
>          cursor =3D self.__get_cursor_begin_events()
> @@ -166,12 +270,24 @@ class Automata:
>                  line =3D self.__dot_lines[cursor].split()
>                  origin_state =3D line[0].replace('"','').replace(',','_')
>                  dest_state =3D line[2].replace('"','').replace(',','_')
> -                possible_events =3D "".join(line[line.index("label")+2:-=
1]).replace('"', '')
> +                possible_events =3D "".join(line[line.index("label") + 2=
:-1]).replace('"', '')
>                  for event in possible_events.split("\\n"):
> +                    event, *constr =3D event.split(";")
> +                    if constr:
> +                        key =3D _EventConstraintKey(states_dict[origin_s=
tate], events_dict[event])
> +                        constraints[key] =3D constr
> +                        # those events reset also on self loops
> +                        if origin_state =3D=3D dest_state and "reset" in=
 "".join(constr):
> +                            self.self_loop_reset_events.add(event)

[Severity: High]
Does recording these events globally create issues when the same event
triggers different behavior in other states?

When an event triggers a variable reset on a self-loop, it is recorded
by name in the global self_loop_reset_events set without associating it
with the specific state where the reset occurs.

> diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification=
/rvgen/rvgen/dot2k.py
> --- a/tools/verification/rvgen/rvgen/dot2k.py
> +++ b/tools/verification/rvgen/rvgen/dot2k.py

[ ... ]

> +class ha2k(dot2k):
> +    """Hybrid automata only"""
> +    def __init__(self, *args, **kwargs):
> +        super().__init__(*args, **kwargs)
> +        if not self.is_hybrid_automata():
> +            raise ValueError("Detected deterministic automata, use the '=
da' class")
> +        self.trace_h =3D self._read_template_file("trace_hybrid.h")
> +        self.__parse_constraints()
> +
> +    def fill_monitor_class_type(self) -> str:
> +        if self.monitor_type =3D=3D "per_task":
> +            return "HA_MON_EVENTS_ID"
> +        return "HA_MON_EVENTS_IMPLICIT"
> +
> +    def fill_monitor_class(self) -> str:
> +        """
> +        Used for tracepoint classes, since they are shared we keep da
> +        instead of ha (also for the ha specific tracepoints).
> +        The tracepoint class is not visible to the tools.
> +        """
> +        return super().fill_monitor_class()

[Severity: High]
Does this method return the correct tracepoint class?

The docstring mentions keeping 'da' instead of 'ha' because tracepoint
classes are shared. However, calling super().fill_monitor_class()
returns self.monitor_class, which is set to 'ha' for this subclass.

This generates DEFINE_EVENT(error_ha, ...) in the C code, but the
error_ha tracepoint class is not declared in the kernel headers, which
expect error_da. Could this lead to compilation failures?

[ ... ]

> +    def __format_guard_rules(self, rules: list[str]) -> list[str]:
> +        """
> +        Merge guard constraints as a single C return statement.
> +        If the rules include a stored env, also check its validity.
> +        Break lines in a best effort way that tries to keep readability.
> +        """
> +        if not rules:
> +            return []
> +
> +        invalid_checks =3D [f"ha_monitor_env_invalid(ha_mon, {env}{self.=
enum_suffix}) ||"
> +                          for env in self.env_stored if any(env in rule =
for rule in rules)]

[Severity: High]
Can this substring check incorrectly match unrelated variables in the
generated C code?

The expression "env in rule" checks if the variable name is a substring
of the generated C code. If env is a short string like "i", it will match
inside unrelated words like "time_ns".

This could inject spurious ha_monitor_env_invalid() checks for the wrong
environment variables. If those variables are uninitialized, the
condition short-circuits to true, incorrectly allowing state transitions.

[ ... ]

> +    def __parse_constraints(self) -> None:
> +        self.guards: dict[_EventConstraintKey, str] =3D {}
> +        self.invariants: dict[_StateConstraintKey, str] =3D {}
> +        for key, constraint in self.constraints.items():
> +            rules =3D []
> +            resets =3D []
> +            for c, sep in self._split_constraint_expr(constraint):

[ ... ]

> +            if self.is_event_constraint(key):
> +                res =3D self.__format_guard_rules(rules) + resets
> +                self.guards[key] =3D ";".join(res)
> +            else:
> +                self.invariants[key] =3D rules[0]

[Severity: Medium]
Are subsequent rules silently ignored here?

When parsing state invariants with multiple rules separated by logical
operators, this assignment only stores the first parsed rule and discards
the rest.=20

Does this mean the generated monitor might fail to enforce all specified
invariants?

[ ... ]

> +    def __find_inv_conflicts(self) -> tuple[set[tuple[int, _EventConstra=
intKey]],
> +                                            set[tuple[int, _StateConstra=
intKey]]]:
> +        """
> +        Run a breadth first search from all states with an invariant.
> +        Find any conflicting constraints reachable from there, this can =
be
> +        another state with an invariant or an edge with a non-reset guar=
d.
> +        Stop when we find a reset.
> +
> +        Return the set of conflicting guards and invariants as tuples of
> +        conflicting state and constraint key.
> +        """
> +        conflict_guards: set[tuple[int, _EventConstraintKey]] =3D set()
> +        conflict_invs: set[tuple[int, _StateConstraintKey]] =3D set()
> +        for start_idx in self.invariants:
> +            queue =3D deque([(start_idx, 0)])  # (state_idx, distance)
> +            env =3D self.__get_constraint_env(self.invariants[start_idx])
> +
> +            while queue:
> +                curr_idx, distance =3D queue.popleft()
> +
> +                # Check state condition
> +                if curr_idx !=3D start_idx and curr_idx in self.invarian=
ts:
> +                    conflict_invs.add((start_idx, _StateConstraintKey(cu=
rr_idx)))
> +                    continue
> +
> +                # Check if we should stop
> +                if distance > len(self.states):
> +                    break
> +                if curr_idx !=3D start_idx and distance > 1:
> +                    continue

[Severity: Medium]
Does this condition prematurely stop the breadth-first search?

The BFS algorithm appears designed to explore paths up to len(self.states)
deep, but this check restricts the search to depth 1.

Any paths longer than 1 edge are not explored, which might cause the
generator to silently miss required invariant-to-guard conversions.

> +
> +                for event_idx, next_state_name in enumerate(self.functio=
n[curr_idx]):
> +                    if next_state_name =3D=3D self.invalid_state_str:
> +                        continue
> +                    curr_guard =3D self.guards.get((curr_idx, event_idx)=
, "")
> +                    if "reset" in curr_guard and env in curr_guard:
> +                        continue

[Severity: Medium]
Could this naive substring search yield false positives?

If env is a short string like "t", and curr_guard contains a reset for
a completely different variable like "time_ns" or "limit", the substring
check evaluates to true.

This might wrongly signal that the target variable was reset, causing
the conflict detection loop to skip generating necessary timer
conversions.

[ ... ]

> +    def __fill_setup_invariants_func(self) -> list[str]:
> +        buff =3D []
> +        if not self.invariants:
> +            return []
> +
> +        buff.append(
> +f"""static inline void ha_setup_invariants(struct ha_monitor *ha_mon,
> +\t\t\t\t       enum {self.enum_states_def} curr_state, enum {self.enum_e=
vents_def} event,
> +\t\t\t\t       enum {self.enum_states_def} next_state, u64 time_ns)
> +{{""")
> +
> +        conditions =3D ["next_state =3D=3D curr_state"]
> +        conditions +=3D [f"event !=3D {e}{self.enum_suffix}"
> +                       for e in self.self_loop_reset_events]

[Severity: High]
Could this cause unintended timer restarts?

Because the self_loop_reset_events set records events globally, if any
self-loop occurs with this event name, the generated monitor bypasses
the early return and restarts the invariant timer for the current state.

This means a self-loop reset intended for state A might erroneously
restart the timer in state B, masking potential timing violations.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260330111010.1536=
63-1-gmonaco@redhat.com?part=3D4
